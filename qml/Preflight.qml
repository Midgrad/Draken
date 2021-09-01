import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls
import Industrial.Indicators 1.0 as Indicators

Controls.Popup {
    id: root

    property int fails: 0

    width: Controls.Theme.baseSize * 5

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: [
                { text: qsTr("AHRS"), reliable: params.ahrs },
                { text: qsTr("SNS"), reliable: params.satellite },
                { text: qsTr("Barometric"), reliable: params.barometric },
                { text: qsTr("Pitot"), reliable: params.pitot },
                { text: qsTr("Radalt"), reliable: params.radalt },
                { text: qsTr("Battery"), reliable: params.battery },
                { text: qsTr("Mission"), reliable: params.mission },
                { text: qsTr("Arm ready"), reliable: params.armReady }
            ]

            delegate: ChecklistItem {
                text: modelData.text
                failed: !modelData.reliable
                active: typeof(params.online) !== "undefined" && params.online
                onFailedChanged: failed ? fails++ : fails --
                Layout.fillWidth: true
            }
        }

        Item {
            Layout.minimumHeight: Controls.Theme.padding
            Layout.fillHeight: true
        }

        Controls.DelayButton {
            flat: true
            text: params.armed ? qsTr("Disarm throttle"): qsTr("Arm throttle")
            onActivated: setParam("setArmed", !params.armed)
            Layout.fillWidth: true
        }
    }
}
