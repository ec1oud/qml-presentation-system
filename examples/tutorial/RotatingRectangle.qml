import QtQuick 2.0

Rectangle {
    id: box
    width: 100
    height: width
    color: mouse.pressed ? "lightsteelblue" : "steelblue"
    antialiasing: true

    NumberAnimation on rotation { from: 0; to: 360; duration: 10000; loops: Animation.Infinite; running: visible }

    Text {
        text: "Click Me!"
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        drag.target: box
    }
}

