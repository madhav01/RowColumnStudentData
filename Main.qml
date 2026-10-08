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
}
