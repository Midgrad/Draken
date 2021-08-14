import QtQuick 2.6
import Industrial.Controls 1.0 as Controls
import Industrial.Indicators 1.0 as Indicators
import Dreka.Draken 1.0

Column {
    id: root

    readonly property var tmi: controller.parameters

    property alias vehicle: controller.root

    // TODO: to helper
    function guardNaN(value) { return value ? value : NaN; }

    spacing: Controls.Theme.spacing

    ParametersController { id: controller }

    Indicators.Text { text: qsTr("STATE: -") }

    Row {
        spacing: 0

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 3.75

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("GS")
                tipText: qsTr("Ground speed")
                value: guardNaN(tmi.gs)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("IAS")
                tipText: qsTr("Indicated air speed")
                value: guardNaN(tmi.ias)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("TAS")
                tipText: qsTr("True air speed")
                value: guardNaN(tmi.tas)
            }
        }

        Indicators.AttitudeIndicator {
            id: ai
            width: root.width / 2.15
            height: width * 1.35
            markWidth: 1.5
            markFactor: 0.8
            zigzag: 7
            pitch: guardNaN(tmi.pitch)
            roll: guardNaN(tmi.roll)

            Indicators.ValueLabel {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -parent.height / 4
                prefixFont.pixelSize: Controls.Theme.auxFontSize * 0.8
                prefix: qsTr("PTCH")
                value: ai.pitch
            }

            Indicators.ValueLabel {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: parent.height / 4
                prefixFont.pixelSize: Controls.Theme.auxFontSize * 0.8
                prefix: qsTr("ROLL")
                value: ai.roll
            }
        }

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 3.75

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("ALT")
                tipText: qsTr("Satellite altitude above main sea level")
                value: guardNaN(tmi.satelliteAltitude)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("HGT")
                tipText: qsTr("Height relative HOME position")
                value: guardNaN(tmi.relativeHeight)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("ELV")
                tipText: qsTr("Elevation above terrain")
                value: guardNaN(tmi.elevation)
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
