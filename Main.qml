import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Window{
    width: Screen.width
    height: Screen.height
    // width: 1920
    // height: 500
    visible: true

    Rectangle {
        id: mainContainer
        width: parent.width
        height: parent.height
        // property string imgpath: `file:///usr/Qt_assets/`


        // property string imgpath: `file:///usr/share/examples/boot2qt-launcher-demos/qtcluster/Qt_assets/`
        // property string imgpath: "file:///home/ayush/Documents/Qt_assets/"
        property string imgpath: "file:///home/lab/Pictures/Qt_Cluster/Qt_assets"
        // property string imgpath: "file:///usr/Qt_assets"

        // property string imgpath: "file:///home/ayush/Documents/Qt_assets/"
        gradient: Gradient {
            GradientStop {
                position: 0.0007
                color: "#030C21"
            }
            GradientStop {
                position: 0.2653
                color: "#0D141F"
            }
            GradientStop {
                position: 0.9993
                color: "#092141"
            }
        }
        GridLayout {
            anchors.fill: parent
            columns: 1

            Rectangle {
                id: rectTop
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.height * 0.25
                color: "transparent"
                Rectangle {
                    id: musicBar
                    width: parent.width * 0.55
                    height: parent.height * 0.55
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    anchors.top: topbar.bottom
                    anchors.topMargin: -(topbar.height * 0.55)
                    Image {
                        id: musicTab
                        source: mainContainer.imgpath + "/musicTab.png"
                        anchors.fill: parent
                        Rectangle {
                            id: music
                            height: parent.height
                            width: parent.width * 0.6
                            anchors.top: musicTab.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "transparent"
                            Image {
                                id: musicIcon
                                source: mainContainer.imgpath + "/musicIcon"
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: 5
                                anchors.leftMargin: parent.width * 0.12
                            }

                            Rectangle {
                                id: animateMusic
                                width: parent.width*0.6
                                height: parent.height*0.6
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: 5
                                color: "transparent"
                                clip: true
                                anchors.left: musicIcon.left
                                anchors.leftMargin: parent.width * 0.1

                                Text {
                                    id: musicName
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.leftMargin: parent.width * 0.25
                                    text: tcpClient.title + " | " + tcpClient.artist

                                    font.family: "Goldman"
                                    color: "white"
                                    font.weight: Font.Normal
                                    font.pixelSize: 25

                                    width: musicName.contentWidth

                                    // Initial position
                                    x: parent.width

                                    // Animation to move the text from right to left
                                    SequentialAnimation {
                                        loops: Animation.Infinite  // Makes the animation repeat indefinitely
                                        running: true

                                        // Animation to move the text to the left
                                        PropertyAnimation {
                                            target: musicName
                                            property: "x"
                                            to: -musicName.width
                                            duration: 10000  // Adjust duration to control speed
                                        }
                                        // Reset the position after one cycle and make the text visible again
                                        PropertyAnimation {
                                            target: musicName
                                            property: "x"
                                            to: musicName.width
                                            duration: 0  // Instant reset
                                        }
                                    }

                                }
                            }

                        }

                    }

                }
                Rectangle {
                    id: topbar
                    width: parent.width
                    height: parent.height * 0.6
                    anchors.top: parent.top
                    color: "transparent"
                    Image {
                        id: imgtop
                        source: mainContainer.imgpath + "/imgtop.png"
                        anchors.fill: parent
                        Image {
                            id: vector2
                            source: mainContainer.imgpath + "/Vector (2).png"
                            fillMode: Image.PreserveAspectFit
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.19
                            width: parent.width * 0.02
                            height: parent.height * 0.20

                        }
                        ProgressBar{
                            id: battery
                            width: 200
                            height: 10
                            from: 0
                            to: 100
                            value: 100
                            anchors.left: vector2.right
                            anchors.leftMargin: vector2.width*0.3
                            anchors.verticalCenter: parent.verticalCenter
                            property double batterydifference:100
                            PropertyAnimation {
                                id: decWidth
                                target: battery
                                property: "value"
                                from: 100
                                to: 30
                                duration: 900000

                            }
                            onValueChanged: {

                                mainContainer.chargeDistance =  Math.ceil(value * 4.4)
                                mainContainer.changeFuelAngle += (batterydifference - value) *0.9
                                batterydifference = value
                            }
                        }
                        Text{
                            id: batteryText
                            font.weight: Font.Normal // Weight 400 corresponds to Font.Normal in QML
                            font.pixelSize: 20
                            anchors.left: battery.right
                            anchors.leftMargin: battery.width*0.1
                            anchors.verticalCenter: vector2.verticalCenter
                            text: Math.ceil(battery.value) + "%"
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                        }

                        /*
                        Rectangle {
                            id: rectanglebattery
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.215
                            width: 100
                            height: parent.height * 0.025
                            color: "Black"

                            Rectangle {
                                id: rectangleinside
                                color: "#d9d9d9"
                                width: rectanglebattery.width
                                height: rectanglebattery.height
                            }
                            PropertyAnimation {
                                id: decWidth
                                target: rectangleinside
                                property: "width"
                                from: rectanglebattery.width
                                to: 30
                                duration: 150000
                            }

                            Text {
                                id: battPer
                                text: "90 %"
                                anchors.left: parent.right
                                anchors.leftMargin: rectanglebattery.width * 0.1
                                anchors.verticalCenter: parent.verticalCenter
                                font.family: "Goldman"
                                color: "white"
                                font.weight: Font.Normal // Weight 400 corresponds to Font.Normal in QML
                                font.pixelSize: 20
                            }

                        }
                        */
                        Image {
                            id: p
                            width: parent.width * 0.02
                            height: parent.height * 0.23
                            source: mainContainer.imgpath + "/P.png"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.40
                        }
                        Image {
                            id: n
                            width: parent.width * 0.02
                            height: parent.height * 0.23
                            source: mainContainer.imgpath + "/N.png"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.45
                        }
                        Image {
                            id: d
                            width: parent.width * 0.02
                            height: parent.height * 0.23
                            source: mainContainer.imgpath + "/D.png"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.50
                        }
                        Image {
                            id: r
                            width: parent.width * 0.02
                            height: parent.height * 0.23
                            source: mainContainer.imgpath + "/R.png"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.55
                        }

                        Image {
                            id: seatbelt

                            source: mainContainer.imgpath + "/seatbelt.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.65
                            width: parent.width * 0.1
                            height: parent.height * 0.22
                        }
                        Image {
                            id: alert

                            source: mainContainer.imgpath + "/Group.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.70
                            width: parent.width * 0.1
                            height: parent.height * 0.22
                        }
                        Image {
                            id: steering

                            source: mainContainer.imgpath + "/steering.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: parent.width * 0.75
                            width: parent.width * 0.1
                            height: parent.height * 0.22
                        }
                    }
                }

                Image {
                    id: vectorwhiteleft

                    source: mainContainer.imgpath + "/Vector (1).png"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: parent.width * 0.0
                    width: parent.width * 0.20
                    height: parent.height * 0.25
                }

                Image {
                    id: vectorgreenleft

                    source: mainContainer.imgpath + "/Vector right (copy)"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: parent.width * 0.0
                    width: parent.width * 0.20
                    height: parent.height * 0.25
                }

                Image {
                    id: vectorwhiteright

                    source: mainContainer.imgpath + "/Vector left (copy)"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: parent.width * 0.80
                    width: parent.width * 0.20
                    height: parent.height * 0.25
                }
                Image {
                    id: vectorgreenright

                    source: mainContainer.imgpath + "/Vector"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    fillMode: Image.PreserveAspectFit
                    anchors.leftMargin: parent.width * 0.80
                    width: parent.width * 0.20
                    height: parent.height * 0.25
                }
                RowLayout {
                    anchors.top: parent.top
                    anchors.right: vectorgreenright.left  // Align to the left of vectorgreenright
                            anchors.rightMargin: vectorgreenright.width * 0.005 // 25% of vectorgreenright's width as margin
                    anchors.margins: 11

                    anchors.topMargin: 203 // Keeps the layout aligned with your `y: 11`
                    spacing: 40 // Adjust space between images

                    Image {
                        id: carengine
                        source: mainContainer.imgpath + "/carengine.png"
                        fillMode: Image.PreserveAspectFit
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                    }

                    Image {
                        id: parking
                        source: mainContainer.imgpath + "/parking.png"
                        fillMode: Image.PreserveAspectFit
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                    }

                    Image {
                        id: abs
                        source: mainContainer.imgpath + "/abs.png"
                        fillMode: Image.PreserveAspectFit
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                    }
                }

            }

            Rectangle {
                id: rectMiddle
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.height * 0.66
                color: "transparent"
                Layout.topMargin : -(rectTop.height * 0.26)

                Rectangle {
                    id: midTop
                    width: parent.width
                    height: parent.height * 0.15
                    color: "transparent"

                    Image {
                        id: turnright
                        visible: false
                        source: mainContainer.imgpath + "/Group 293.png"
                        anchors.top: midTop.top
                        anchors.horizontalCenter: parent.horizontalCenter // Left margin as a percentage of parent width
                        anchors.horizontalCenterOffset: (turnleft.width * 0.5)
                        width: parent.width * 0.03
                        height: parent.width * 0.03
                        fillMode: Image.PreserveAspectFit
                    }
                    Image {
                        id: turnleft
                        visible: false
                        source: mainContainer.imgpath + "/turnleft"
                        width: parent.width * 0.03
                        height: parent.width * 0.03
                        anchors.top: midTop.top
                        anchors.horizontalCenterOffset: -(turnleft.width * 0.5)
                        anchors.horizontalCenter: parent.horizontalCenter // Left margin as a percentage of parent width

                        fillMode: Image.PreserveAspectFit
                    }
                    Text {
                        id: turnDistance
                        text: " "
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: turnleft.bottom
                        anchors.topMargin: turnleft.height * 0.2
                        font.family: "Goldman"
                        color: "white"
                        font.weight: Font.Normal // Weight 400 corresponds to Font.Normal in QML
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        lineHeight: 72 / 60
                    }

                    Image {
                        id: charge
                        source: mainContainer.imgpath + "/charge.png"
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width *0.55
                        // Left margin as a percentage of parent width
                        width: parent.width * 0.03
                        height: parent.height * 0.40
                        fillMode: Image.PreserveAspectFit
                    }
                    Text {
                        id: _440km
                        anchors.left: charge.right
                        anchors.leftMargin: charge.width * 0.1
                        anchors.verticalCenter: charge.verticalCenter
                        anchors.verticalCenterOffset:  charge.height * 0.1
                        width: parent.width * 0.05
                        height: charge.height
                        text: 440 + "km"
                        font.family: "Goldman"
                        color: "white"
                        font.weight: Font.Normal // Weight 400 corresponds to Font.Normal in QML
                        font.pixelSize: 25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                    }

                }

                Rectangle {
                    id: midBottom
                    width: parent.width * 0.9
                    height: parent.height * 0.84
                    anchors.top: midTop.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    Image {
                        id: midPanel
                        width: parent.width
                        height: parent.height * 0.66
                        source: mainContainer.imgpath + "/Group 299 (1).png"
                        anchors.fill: parent
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        Row {
                            id: midColumn
                            width: parent.width
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            Item {
                                id: speedTab
                                width: parent.width * 0.3
                                height: parent.height
                                Text {
                                    id: speed
                                    text: mainContainer.speed
                                    font.family: "Goldman"
                                    color: "white"
                                    font.weight: Font.Normal
                                    font.pixelSize: 90
                                    anchors.right: parent.right
                                    anchors.rightMargin: parent.width * 0.01
                                    anchors.top: parent.top
                                    anchors.topMargin: parent.height * 0.15
                                    width: parent.width * 0.4
                                    height: parent.height * 0.23
                                    Text {
                                        id: km
                                        anchors.top: speed.bottom
                                        anchors.left: speed.left
                                        width: parent.width * 0.13
                                        height: parent.height * 0.25
                                        text: "km/h"
                                        font.family: "Goldman"
                                        color: "white"
                                        font.weight: Font.Normal
                                        font.pixelSize: 40
                                    }
                                }
                            }
                            Item {
                                id: carPart
                                width: parent.width * 0.4
                                height: parent.height
                                Image {
                                    id: carLight
                                    source: mainContainer.imgpath + "/Vector 135"
                                    visible: true
                                    width: parent.width * 0.3
                                    height: parent.height * 0.3
                                    anchors.bottom: car.top
                                    anchors.bottomMargin: -(parent.height*0.215)
                                    anchors.horizontalCenter: car.horizontalCenter
                                    fillMode: Image.PreserveAspectFit
                                    transform: Rotation {
                                        id: rotateCarLight
                                        angle: 0 // Initial angle
                                        origin.x: carLight.width * 0.5
                                        origin.y: carLight.height * 0.9
                                    }
                                }
                                Image {
                                    id: carLightlow
                                    source: mainContainer.imgpath + "/lowlight.png"
                                    visible: true
                                    width: parent.width * 0.3
                                    height: parent.height * 0.2
                                    anchors.horizontalCenter: carLight.horizontalCenter
                                    anchors.bottom: car.top
                                    anchors.bottomMargin: -(parent.height*0.215)
                                    fillMode: Image.PreserveAspectFit
                                    transform: Rotation {
                                        id: rotateCarLightLow
                                        angle: 0 // Initial angle
                                        origin.x: carLight.width * 0.5
                                        origin.y: carLight.height * 0.8
                                    }
                                }

                                Image {
                                    id: car
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: parent.width*0.1
                                    anchors.bottom: parent.bottom

                                    width: parent.width * 0.5
                                    height: parent.height * 0.48

                                    source: mainContainer.imgpath + "/Group 305"
                                    fillMode: Image.PreserveAspectFit
                                }
                            }
                            Item {
                                id: rpmTab
                                width: parent.width * 0.3
                                height: parent.height
                                Text {
                                    id: rpm
                                    text: mainContainer.rpm
                                    font.family: "Goldman"
                                    color: "white"
                                    font.weight: Font.Normal
                                    font.pixelSize: 90
                                    anchors.left: parent.left
                                    anchors.leftMargin: parent.width * 0.2
                                    anchors.top: parent.top
                                    anchors.topMargin: parent.height * 0.15
                                    width: parent.width * 0.3
                                    height: parent.height * 0.23
                                    Text {
                                        id: rpmh
                                        anchors.top: rpm.bottom
                                        anchors.left: rpm.left
                                        width: parent.width * 2
                                        height: parent.height
                                        text: "x1000 RPM"
                                        font.family: "Goldman"
                                        color: "white"
                                        font.weight: Font.Normal
                                        font.pixelSize: 40
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: temperaturerectangle
                            color: "transparent"
                            anchors.bottom: parent.bottom // Fixed incorrect multiplication
                            // height: midBottom.height * 0.25
                            // width: midBottom.height * 0.25
                            height: midBottom.height * 0.2
                            width: midBottom.height * 0.2
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.01
                            anchors.bottomMargin: -27

                            Image {
                                id: temperatureArc
                                height: parent.height
                                width: parent.width
                                source: mainContainer.imgpath + "/Temperature.png"
                                fillMode: Image.PreserveAspectFit

                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter

                                Image {
                                    id: needletemperature

                                    // anchors.bottom: parent.bottom
                                    source: mainContainer.imgpath + "/needleTemperature.png"
                                    height: fuelrectangle.height * 0.4
                                    width: fuelrectangle.width * 0.2
                                    // fillMode: Image.PreserveAspectFit
                                    anchors.bottom: parent.bottom
                                    anchors.right: parent.right
                                    anchors.bottomMargin: fuelrectangle.height *0.22
                                    anchors.rightMargin: fuelrectangle.width *0.28
                                    transform: Rotation {
                                        id: rotationTemperature
                                        origin.x: fuelrectangle.width * 0.185
                                        // origin.y:74
                                        origin.y: fuelrectangle.width * 0.385
                                        angle: -60
                                        Behavior on angle {
                                            NumberAnimation {
                                                duration: lowhighTimer.interval
                                            }
                                        }
                                    }

                                    Image {
                                        id: needlecircle1
                                        anchors.right: parent.right
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: -2
                                        anchors.rightMargin: -1
                                        height: fuelrectangle.height * 0.045
                                        width: fuelrectangle.height * 0.045

                                        // x: fuelrectangle.width * 0.185
                                        // y: fuelrectangle.height * 0.385
                                        source: mainContainer.imgpath + "/needlecircle.png"
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: fuelrectangle
                            color: "transparent"
                            anchors.bottom: parent.bottom // Fixed incorrect multiplication
                            height: midBottom.height * 0.2
                            width: midBottom.height * 0.2
                            anchors.right: parent.right
                            anchors.rightMargin: parent.width * 0.01
                            anchors.bottomMargin: -27

                            Image {
                                id: group
                                height: parent.height
                                width: parent.width
                                source: mainContainer.imgpath + "/Fuel.png"
                                fillMode: Image.PreserveAspectFit

                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter

                                Image {
                                    id: needlefuel

                                    // anchors.bottom: parent.bottom
                                    source: mainContainer.imgpath + "/Group (1).png"
                                    height: fuelrectangle.height * 0.45
                                    width: fuelrectangle.width * 0.3
                                    // fillMode: Image.PreserveAspectFit
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.bottomMargin: fuelrectangle.height *0.22
                                    anchors.leftMargin: fuelrectangle.width *0.26
                                    transform: Rotation {
                                        id: rot
                                        origin.x: 2
                                        // origin.y:74
                                        origin.y: fuelrectangle.height * 0.43
                                        angle: mainContainer.changeFuelAngle

                                    }

                                    Image {
                                        id: needlecircle
                                        anchors.left: parent.left
                                        anchors.bottom: parent.bottom
                                        height: fuelrectangle.height * 0.08
                                        width: fuelrectangle.height * 0.08
                                        source: mainContainer.imgpath + "/needlecircle.png"
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: rectBottom
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.height * 0.15
                color: "transparent"
                Layout.topMargin:0
                Image {
                    id: vector134
                    anchors.fill: parent
                    source: mainContainer.imgpath + "/Vector_Bottom.png"

                    Image {
                        id: frame301
                        anchors.horizontalCenter: parent.horizontalCenter

                        width: parent.width * 0.17
                        height: parent.height * 0.7
                        source: mainContainer.imgpath + "/Frame 30.png"
                        fillMode: Image.PreserveAspectFit
                        Text {
                            id:  timeLabel
                            visible: false
                            text: Qt.formatDateTime(new Date(),
                                                    "yyyy-MM-dd | hh:mm:ss")
                            font.family: "Goldman"
                            color: "white"
                            width: contentWidth
                            font.weight: Font.Normal
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -(parent.width *0.015)
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }


                    Image {
                        id: group3
                        anchors.left: parent.left // Aligns to the left side of the parent
                        anchors.leftMargin: parent.width * 0.13 // Adds left padding (adjust the multiplier as needed)
                        anchors.verticalCenter: parent.verticalCenter // Centers vertically in the parent
                        width: parent.width * 0.1 // Scales width relative to parent
                        height: parent.height * 0.3 // Scales height relative to parent
                        source: mainContainer.imgpath + "/Group (3).png"
                        fillMode: Image.PreserveAspectFit
                        Text{
                            id:tempText
                            text: "22°C"
                            font.family: "Goldman"
                            color: "white"
                            font.weight: Font.Normal
                            font.pixelSize: 20
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                        }
                    }

                    Image {
                        id: engine
                        source: mainContainer.imgpath + "/engine.png"
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.25
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.05 // Scales width relative to parent
                        height: parent.height * 0.25
                        fillMode: Image.PreserveAspectFit
                    }

                    Image {
                        id: doors
                        source: mainContainer.imgpath + "/doors.png"
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.33
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.08 // Scales width relative to parent
                        height: parent.height * 0.30
                        fillMode: Image.PreserveAspectFit
                    }

                    Image {
                        id: wipers
                        source: mainContainer.imgpath + "/wiper.png"
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width * 0.33
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.035 // Scales width relative to parent
                        height: parent.height * 0.25
                    }
                    Image {
                        id: lowbeam

                        source: mainContainer.imgpath + "/lowbeam.png"
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width * 0.25
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.035 // Scales width relative to parent
                        height: parent.height * 0.25
                    }

                    Image {
                        id: lowbeamglow

                        source: mainContainer.imgpath + "/lowbeamglow.png"
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width * 0.25
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.035 // Scales width relative to parent
                        height: parent.height * 0.25
                    }
                    Image {
                        id: highbeam
                        source: mainContainer.imgpath + "/highbeam.png"
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width * 0.17
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.035 // Scales width relative to parent
                        height: parent.height * 0.25
                    }
                    Image {
                        id: highbeamglow
                        visible: false
                        source: mainContainer.imgpath + "/highbeamglow.png"
                        anchors.right: parent.right
                        anchors.rightMargin: parent.width * 0.17
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width * 0.035 // Scales width relative to parent
                        height: parent.height * 0.25
                    }
                }
            }
        }

        Button {
            id: btn
            text: "Start"
            visible: false

            onClicked: {
                // Toggle car headlights
                carLightlow.visible = !carLightlow.visible
                decWidth.start()
                // Handle indicators
                if (blinkingTimer.running) {
                    blinkingTimer.stop()
                    vectorgreenright.visible = false
                    vectorgreenleft.visible = true
                } else {
                    vectorgreenright.visible = true
                    vectorgreenleft.visible = false
                    blinkingTimer.start()
                }

                // Toggle hig h beam and low beam
                if (lowhighTimer.running) {
                    lowhighTimer.stop()
                    btn.text = "Start"
                } else {
                    lowhighTimer.start()
                    btn.text = "Stop"
                }
                if (turnDistanceTimer.running) {
                    turnDistanceTimer.stop()
                    turnright.visible = false
                    turnleft.visible = false
                } else {
                    turnDistanceTimer.start()
                    turnright.visible = true
                    // turnDistance.text = "Turn Right\n After " + Math.ceil(
                    //             Math.random() * 1000) + "/m on NH27"
                    turnDistance.text = "Turned Right\n on NH27"
                }

                mainContainer.startTimer();


            }
        }

        Timer {
            id: blinkingTimer
            interval: 15000 // 15 seconds
            repeat: true
            running: false
            onTriggered: {
                // Toggle indicators
                vectorgreenleft.visible = !vectorgreenleft.visible
                vectorgreenright.visible = !vectorgreenright.visible
                if (vectorgreenleft.visible){
                    moveAnimation.start()
                    mainContainer.startAngleCarLight = -10
                    mainContainer.endAngleCarLight = 10
                }
                if (vectorgreenright.visible){
                    moveAnimation.start()
                    mainContainer.startAngleCarLight = 10
                    mainContainer.endAngleCarLight = -10
                }

            }
        }


        PropertyAnimation {
            id: moveAnimation
            targets: [rotateCarLight, rotateCarLightLow]
            property: "angle"
            from: mainContainer.startAngleCarLight
            to: mainContainer.endAngleCarLight
            duration: 10000
            easing.type: Easing.Linear  // Smooth, constant speed rotation
        }

        Timer {
            id: lowhighTimer
            interval:3000  // 30 second
            repeat: true
            running: false
            onTriggered: {
                highbeamglow.visible = !highbeamglow.visible
                lowbeamglow.visible = !lowbeamglow.visible
                if (highbeamglow.visible){
                    carLight.visible = true
                    carLightlow.visible = false
                }
                if(lowbeamglow.visible){
                    carLightlow.visible = true
                    carLight.visible = false

                }
                //Temperature Arc
                rotationTemperature.angle = Math.ceil(mainContainer.speed * 0.5 ) - 64

            }
        }

        Timer {
            id: turnDistanceTimer
            interval: 15000 // 15 sec
            repeat: true
            running: false
            onTriggered: {
                turnright.visible = !turnright.visible
                turnleft.visible = !turnleft.visible
                if (turnright.visible) {
                    // turnDistance.text = "Turn Right\n After " + Math.ceil(
                    //             Math.random() * 1000) + "/m on NH27"
                    turnDistance.text = "Turned Right\n on NH27"
                }
                if (turnleft.visible) {
                    // turnDistance.text = "Turn Left\n After " + Math.ceil(
                    //             Math.random() * 1000) + "/m on NH27"
                    turnDistance.text = "Turned Left\n on NH27"
                }
            }
        }


        Timer {
            id: btnTimer
            interval: 1000
            running: true
            repeat: false
            onTriggered: {
                btn.clicked()
            }
        }


        Timer {
            id: changeValueTimer
            interval: mainContainer.changeDurationSpeedRpm
            repeat: true
            running: false
            onTriggered: {
                if (!mainContainer.changeState) {
                    mainContainer.speed += 1
                } else {
                    mainContainer.speed -= 1
                }
                if ( mainContainer.speed >= 180) {
                    mainContainer.changeState = true
                    mainContainer.changeValue = Math.ceil((Math.random() * 180) + 1)
                }
                if ( mainContainer.speed <= mainContainer.changeValue) {
                    mainContainer.changeState = false
                }
                mainContainer.rpm = Math.ceil( mainContainer.speed / 20)

                //Distance travelled

                // mainContainer.speedAngle = ( mainContainer.speed * (-1)) - 90
                // mainContainer.rpmAngle =  mainContainer.speed - 90



            }
        }
        function startTimer() {
            if (changeValueTimer.running) {
                changeValueTimer.stop()
            } else {
                changeValueTimer.start()
                // mainContainer.changevalue = Math.ceil((Math.random() * 180) + 1)
            }
        }

        Timer {
            id: timeUpdate
            interval: 1000 // 1 second
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var currentDate = new Date()
                // Get UTC time and add 5 hours 30 minutes to get IST
                var istOffset = 5 * 60 * 60 * 1000 + 30 * 60 * 1000
                var istDate = new Date(currentDate.getTime() + istOffset)
                // var istDate = new Date(currentDate.getTime())
                timeLabel.text = Qt.formatDateTime(istDate,
                                                   "yyyy-MM-dd | hh:mm:ss")
            }
        }
        Timer {
            id: timeShow
            interval: 25000
            running: true
            repeat: false
            onTriggered: {
                timeLabel.visible = true
            }
        }


        property int startAngleCarLight: 10
        property int endAngleCarLight: -10
        property bool isAnimating: false
        property bool changeState: false

        property double changeFuelAngle: -30
        property double chargeDistance: 0
        property double changeValue: 0
        property double speedAngle:-87
        property double changeTemperatureAngle: 0
        property double speed: 0
        property double rpm: 0
        property int changeDurationSpeedRpm: 150
    }
}
