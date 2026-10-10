import QtQuick
import QtQuick.Controls.Native

Rectangle{
    id:root

    //Container card styling
    width: parent?parent.width :360
    height: parent ? parent.height : 480
    radius: 10
    color: "#0f172a"
    border.color: "#334155"
    border.width: 1
    clip: true


    //Data passed from backend / parent
    property var studentData: ({})
    property bool showDetails: true

    //========================================================================
    // the column cards vertical without needing anchors cains
    //Notice:
    //1.Childred do not set their own y or verticalCenter anchors
    //2.padding provides uniform inner margins around all 4 edges
    //3.move Transition animate the toggle button when the middle card collapses
    //===========================================================================
    Column{
        id: contentColumn
        anchors.fill: parent
        spacing: 12
        padding: 14

        //smooth 250 ms slide when item above collapes/expand
        move: Transition{
            NumberAnimation{properties: "y";duration: 250;easing.type: Easing.OutQuad}
        }

        //1. Profile header card
        Rectangle{
            width: parent.width-(contentColumn.padding*2)
            height: 70
            radius: 8
            color: "#1e293b"
            border.color: "#334155"

            Row{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 12
                spacing: 12

                //Avatar Icon
                Rectangle{
                    width: 44;height: 44
                    radius: 22
                    color: "#6366f1"
                    anchors.verticalCenter: parent.verticalCenter

                    Text{
                        anchors.centerIn: parent
                        text: (root.studentData && root.studentData.name && root.studentData.name.length>0)
                              ?root.studentData.name.charAt(0).toUpperCase():"?"
                        font.bold: true
                        font.pixelSize: 18
                        color: "white"
                    }
                }
                //Name & Rector ID Stack
                Column{
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3
                    Text{
                        text: (root.studentData && root.studentData.name)?root.studentData.name: "select Student a student"
                        font.bold: true
                        font.pixelSize: 15
                        color: "#f8fafc"
                    }

                    Text{
                        text: (root.studentData && root.studentData.name)?root.studentData.id: "-"
                                                                           + " • "+(root.studentData && root.studentData.status? root.studentData.status:"Active");
                        font.pixelSize: 11
                        color:  "#94a3b8"
                    }
                }
            }

        }
        //2.academic performance card
        Rectangle{
            width: parent.width - (contentColumn.padding*2)
            height: 80
            radius: 8
            color: "#1e293b"
            border.color: "#38bdf8"

            Column{
                anchors.fill: parent
                anchors.margins: 10
                spacing: 6


                Text{
                    text: "📊 Academic Performanc"
                    font.bold: true
                    font.pixelSize: 11
                    color: "#38bdf8"
                }
                Row{
                    spacing: 16
                    Text{
                        text: "Department: " + (root.studentData && root.studentData.department?root.studentData.department:"CS")
                        font.pixelSize: 11
                        color: "#e2e8f0"
                    }
                    Text{
                        text: "GPA: " + (root.studentData && root.studentData.gpa ? Number(root.studentData.gpa).toFixed(2):"0.00")+" /4.00"
                        font.bold: true
                        font.pixelSize: 11
                        color: "#4ade80"
                    }
                }
                // GPA Gauge Progress Bar
                Rectangle{
                    width: parent.width
                    height: 5
                    radius: 2
                    color: "#334155"

                    Rectangle{
                        height: parent.height
                        radius: 2
                        color: "#22c55e"
                        width: {
                            var val = (root.studentData.gpa)?Number(root.studentData.gpa):0
                            return Math.min(parent.width,(val/4.0)*parent.width)
                        }
                    }

                }
            }
        }
        // 3. COLLAPSIBLE SYSTEM DETAILS CARD
        // (Demonstrates Column's automatic space collapse when visible is false!)
        Rectangle{
            id: detailsCard
            width: parent.width-(contentColumn.padding*2)
            height: 75
            radius: 8
            color: "#1e293b"
            border.color: "#334155"
            visible: root.showDetails//When false, Column automatically collapse this space!

            Column{
                anchors.fill: parent
                anchors.margins: 10
                spacing: 6

                Text{
                    text: "⚙ System Details"
                    font.bold: true
                    font.pixelSize: 11
                    color: "#f59e0b"
                }
                Text{
                    text: "Age: "+(root.studentData && root.studentData.age?root.studentData.age:"-")+" year"
                    font.pixelSize: 11
                    color: "#cbd5e1"
                }
                Text{
                    text: "Backend Server: Drogon C++ (Port 8080)"
                    font.pixelSize: 10
                    color: "#64748b"
                }
            }
        }
        //4. INTERACTIVE ACCORDION TOGGLE BUTTON
        Rectangle{
            width: parent.width-(contentColumn.padding * 2)
            height: 32
            radius: 6
            color: "#334155"

            Text{
                anchors.centerIn: parent
                text: root.showDetails ? "Collapse Extra Details Details ▲":"Expand Extra Details ▼"
                font.bold: true
                font.pixelSize: 10
                color: "#f8fafc"
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: "PointingHandCursor"
                onClicked: root.showDetails = !root.showDetails
            }
        }

    }



}
