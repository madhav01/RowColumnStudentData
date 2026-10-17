import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Native
import RowColumnStudentData


ApplicationWindow {
    id: window
    width: 640
    height: 480
    minimumWidth: 200
    minimumHeight: 250
    visible: true
    title: qsTr("RowColumnTest")

    MyBackend{
        id:mybackend
    }

    Row{
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16


        //====================================================
        //Left Half: Student List (a Column holding each StudentRowItem
        //============================================================

        Column{
            width: parent.width*0.55
            height: parent.height
            spacing: 10

            //Title lable
            Text{
                text: "📋 Active Students List (Row Positioners)"
                font.bold: true
                font.pixelSize: 14
                color: "#171717"
            }
            //Scrollable list container
            Flickable{
                width: parent.width
                height: parent.height-30
                contentHeight: studentListColumn.implicitHeight
                clip: true

                Column{
                    id:studentListColumn
                    width: parent.width
                    spacing: 8

                    // Repeater creates a StudentRowItem for every student in C++!
                    Repeater{
                        model: mybackend.students

                        StudentRowItem {
                            studentData: modelData
                            itemIndex:index
                            isSelected: mybackend.selectedStudent.id === modelData.id
                            onInspectClicked: function(id) {
                                mybackend.selectStudent(id) // Calls C++!
                            }
                        }
                    }
                }
            }
        }

        // Right Half: Student Metadata Inspector (Column Positioner)
        StudentMetaColumn {
            width: parent.width * 0.45 - 16
            height: parent.height
            studentData: mybackend.selectedStudent // Binds to C++!
        }
    }
}