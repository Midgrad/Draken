import QtQuick 2.6
import Industrial.Controls 1.0 as Controls
import Industrial.Indicators 1.0 as Indicators
import Dreka.Draken 1.0

Column {
    id: root

    readonly property var params: controller.parameters

    property alias vehicle: controller.root

    // TODO: to helper
    function guardNaN(value) { return value ? value : NaN; }

    spacing: Controls.Theme.spacing

    ParametersController { id: controller }

    Indicators.Text { text: qsTr("STATE") + ": " + params.state ? params.state : "-" }

    Row {
        spacing: 0

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 3.75

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("GS")
                tipText: qsTr("Ground speed")
                value: guardNaN(params.gs)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("IAS")
                tipText: qsTr("Indicated air speed")
                value: guardNaN(params.ias)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("TAS")
                tipText: qsTr("True air speed")
                value: guardNaN(params.tas)
            }
        }

        Indicators.AttitudeIndicator {
            id: ai
            width: root.width / 2.15
            height: width * 1.35
            markWidth: 1.5
            markFactor: 0.8
            zigzag: 7
            pitch: guardNaN(params.pitch)
            roll: guardNaN(params.roll)

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
                value: guardNaN(params.satelliteAltitude)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("HGT")
                tipText: qsTr("Height relative HOME position")
                value: guardNaN(params.relativeHeight)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("ELV")
                tipText: qsTr("Elevation above terrain")
                value: guardNaN(params.elevation)
            }
        }
    }

    Row {
        spacing: 0

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 4

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("HDG")
                value: compas.heading
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("CRS")
                value: compas.course
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
            heading: guardNaN(params.heading)
            course: guardNaN(params.course)
        }

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 4

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("WP")
                value: guardNaN(params.wpDistance)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("HOME")
                value: guardNaN(params.homeDistance)
            }
        }
    }

    Row {
        spacing: 0

        Controls.ComboBox {
            width: root.width / 2
            flat: true
            labelText: qsTr("Mode")
            model: params.modes ? params.modes : []
            displayText: params.mode ? params.mode : ""
        }

        Controls.ComboBox {
            width: root.width / 2
            flat: true
            labelText: qsTr("WP")
            model: params.wps ? params.wps : 0
            displayText: params.wp ? params.wp : 0
        }
    }
}
