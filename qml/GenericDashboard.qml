import QtQuick 2.6
import Industrial.Controls 1.0 as Controls
import Industrial.Indicators 1.0 as Indicators
import Dreka.Draken 1.0

Column {
    id: root

    spacing: Controls.Theme.spacing

    Indicators.Text { text: qsTr("STATE: -") }

    Row {
        spacing: 0

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 3.75

            Indicators.ValueLabel {
                prefix: qsTr("GS")
                width: parent.width
            }

            Indicators.ValueLabel {
                prefix: qsTr("IAS")
                width: parent.width
            }

            Indicators.ValueLabel {
                prefix: qsTr("TAS")
                width: parent.width
            }
        }

        Indicators.AttitudeIndicator {
            id: ai
            width: root.width / 2.15
            height: width * 1.35
            markWidth: 1.5
            markFactor: 0.9
            zigzag: 7

            Indicators.ValueLabel {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -parent.height / 4
                prefixFont.pixelSize: Controls.Theme.auxFontSize * 0.8
                prefix: qsTr("PTCH")
            }

            Indicators.ValueLabel {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: parent.height / 4
                prefixFont.pixelSize: Controls.Theme.auxFontSize * 0.8
                prefix: qsTr("ROLL")
            }
        }

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 3.75

            Indicators.ValueLabel {
                prefix: qsTr("SAT")
                width: parent.width
            }

            Indicators.ValueLabel {
                prefix: qsTr("ALT")
                width: parent.width
            }

            Indicators.ValueLabel {
                prefix: qsTr("HGT")
                width: parent.width
            }
        }
    }

    Row {
        spacing: 0

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 4

            Indicators.ValueLabel {
                prefix: qsTr("HDG")
                width: parent.width
            }

            Indicators.ValueLabel {
                prefix: qsTr("CRS")
                width: parent.width
            }
        }

        Indicators.Compass {
            id: compas
            width: root.width / 2
            tickFactor: 15
            fontSize: height * 0.115
            tickTextedSize: fontSize * 0.3
            textOffset: fontSize * 1.5
            arrowSize: width * 0.2
            mark: "qrc:/icons/generic_aircraft.svg"
        }

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 4

            Indicators.ValueLabel {
                prefix: qsTr("WP")
                width: parent.width
            }

            Indicators.ValueLabel {
                prefix: qsTr("HOME")
                width: parent.width
            }
        }
    }
}
