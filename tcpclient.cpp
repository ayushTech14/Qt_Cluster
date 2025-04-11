#include "tcpclient.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QTcpSocket>
#include <QDebug>
#include <QRegularExpression>

#define FILENAME "/tmp/data.txt"
#define PORT 44820

TcpClient::TcpClient(QObject *parent) : QObject(parent), socket(new QTcpSocket(this))
{
    connect(socket, &QTcpSocket::readyRead, this, &TcpClient::receiveNotification);
    connect(socket, &QTcpSocket::connected, this, &TcpClient::onConnected);

}

void TcpClient::connectToServer()
{
    socket->connectToHost("127.0.0.1", PORT);
    qDebug() << "Connecting to server";
}

void TcpClient::onConnected()
{
    qDebug() << "Socket state:" << socket->state();
    qDebug() << "Connected to server. Waiting for notifications...";

}


void TcpClient::receiveNotification()
{
    QByteArray data = socket->readAll();
    qDebug() << "Received notification:" << data;
    data.clear();
    // After receiving the notification, read and display the file contents
    readAndDisplayFile();
}

void TcpClient::readAndDisplayFile()
{
    QFile file(FILENAME);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        QString receivedData = in.readAll();
        qDebug() << "Contents of /tmp/data.txt:" << receivedData;

        // Define a regular expression pattern to match the data
        QRegularExpression regex("Title: (.*?), Artist: (.*?), Album: (.*?), Status: (.*)");
        QRegularExpressionMatch match = regex.match(receivedData);

        // Clear the buffer after it's no longer needed for matching or extraction
        qDebug() << "This is match: "<< match;
        receivedData.clear();

        if (match.hasMatch()) {
            // Extract the title, artist, album, and status
            m_title = match.captured(1);
            m_artist = match.captured(2);
            m_album = match.captured(3);
            m_status = match.captured(4);

            qDebug() << "Parsed Data - Title:" << m_title << ", Artist:" << m_artist
                     << ", Album:" << m_album << ", Status:" << m_status;

            emit dataReceived(); // Notify QML that new data is available
        }
        file.close();
    } else {
        qDebug() << "Failed to open /tmp/data.txt";
    }

}
