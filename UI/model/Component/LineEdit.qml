import QtQuick 2.0

Item {
    id: lineEdit
    width: 350; height:52;

    //font
    property string tipText: ""
    property alias text: textEdit
    property string iconFile: ""

    property bool isPassword: false

    Rectangle {
        id:textBackground
        color: "black"

        Image {
            id: icon
            source: iconFile
            anchors.right: parent.right
            anchors.rightMargin: 18
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    TextInput {
        id: textEdit
        anchors.fill: parent;
        anchors.margins: 12; anchors.rightMargin: 35
        verticalAlignment: TextInput.AlignVCenter
        font.pointSize: 14
        font.family: "微软雅黑"
        selectByMouse: true
        clip: true
        text: tipText

        onTextChanged: {
            updateView();
        }

        onFocusChanged: {
            updateView();
        }
    }

    function updateView() {
        if (textEdit.text == "" || textEdit.text == tipText){
            textEdit.color = "#a09d58"
        } else {
            textEdit.color = "black"
        }

        if (textEdit.focus) {
            textEdit.text = textEdit.text == tipText ? "" : textEdit.text;
        } else {
            textEdit.text = textEdit.text == "" ? tipText : textEdit.text;
        }

        if (isPassword) {
            textEdit.echoMode =  textEdit.text == tipText ? TextInput.Normal : TextInput.Password
        }
    }
}
