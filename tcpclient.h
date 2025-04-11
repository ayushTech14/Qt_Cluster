#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>

class TcpClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title NOTIFY dataReceived)
    Q_PROPERTY(QString artist READ artist NOTIFY dataReceived)
    Q_PROPERTY(QString duration READ duration NOTIFY dataReceived)

public:
    explicit TcpClient(QObject *parent = nullptr);
    void connectToServer();
    QString title() const { return m_title; }
    QString artist() const { return m_artist; }
    QString duration() const { return m_duration; }
signals:
    void dataReceived();
private slots:
    void onConnected();
    void receiveNotification();

private:
    void readAndDisplayFile();
    QTcpSocket *socket;
    QString m_title = "No Records";
    QString m_artist = "No Records";
    QString m_duration = "No Records";
    QString m_album = "No Record";
    QString m_status = "No Record";
};

#endif // TCPCLIENT_H
