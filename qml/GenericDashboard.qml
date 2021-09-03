import QtQuick 2.6
import Industrial.Controls 1.0 as Controls
import Industrial.Indicators 1.0 as Indicators
import Dreka.Draken 1.0

Column {
    id: root

    property var params: []

    Connections {
        target: controller
        onSelectedVehicleChanged: params = controller.vehicleData(controller.selectedVehicle)
        onVehicleDataChanged: if (vehicle === controller.selectedVehicle) params = data
    }

    // TODO: to helper
    function setParam(param, data) {
        var object = {};
        object[param] = data;
        controller.setVehicleData(controller.selectedVehicle, object);
    }

    function guardNaN(value) { return value ? value : NaN; }
    function guardBool(value) { return typeof value !== "undefined" && value; }

    spacing: Controls.Theme.spacing
    width: Controls.Theme.baseSize * 6

    Row {
        visible: maximized

        Controls.Button {
            flat: true
            rightCropped: true
            iconSource: "qrc:/icons/calibrate.svg"
            tipText: qsTr("Preparation")
            highlighted: preflight.visible
            onClicked: preflight.visible ? preflight.close() : preflight.open()

            Preflight {
                id: preflight
                closePolicy: Controls.Popup.CloseOnPressOutsideParent
                x: -width - Controls.Theme.margins - Controls.Theme.spacing
            }
        }

        Indicators.Text {
            anchors.verticalCenter: parent.verticalCenter
            width: (root.width - Controls.Theme.baseSize) / 2
            color: params.state ? Indicators.Theme.textColor : Indicators.Theme.disabledColor
            text: params.state ? params.state : "-"
        }

        Indicators.Text {
            anchors.verticalCenter: parent.verticalCenter
            width: (root.width - Controls.Theme.baseSize) / 2
            color: params.armed ? Indicators.Theme.textColor : Indicators.Theme.disabledColor
            text: params.armed ? qsTr("ARMED") : qsTr("DISARMED")
        }
    }

    Row {
        visible: maximized

        Controls.Button {
            flat: true
            height: parent.height
            rightCropped: true
            enabled: typeof params.latitude !== "undefined" && typeof params.longitude !== "undefined"
            iconSource: controller.tracking ? "qrc:/icons/cancel_track.svg" : "qrc:/icons/track.svg"
            tipText: controller.tracking ? qsTr("Cancel track") : qsTr("Track")
            onClicked: controller.setTracking(!controller.tracking )
        }

        Column {
            Indicators.Text {
                color: params.latitude ? Indicators.Theme.textColor : Indicators.Theme.disabledColor
                text: qsTr("Lat") + ":\t" +
                      (params.latitude ? Controls.Helper.degreesToDmsString(params.latitude, false, 2)
                                       : "-")
            }

            Indicators.Text {
                color: params.longitude ? Indicators.Theme.textColor : Indicators.Theme.disabledColor
                text: qsTr("Lon") + ":\t" +
                      (params.longitude ? Controls.Helper.degreesToDmsString(params.longitude, true, 2)
                                        : "-")
            }
        }
    }

    Row {
        visible: maximized
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
                prefix: qsTr("AS")
                tipText: qsTr("Indicated air speed")
                value: guardNaN(params.ias)
            }

            Indicators.Text { width: parent.width; text: qsTr("m/s") }
        }

        Indicators.AttitudeIndicator {
            id: ai
            width: root.width / 2.15
            height: width * 1.35
            markWidth: 1.5
            markFactor: 0.8
            zigzag: 7
            online: guardBool(params.online)
            ready: guardBool(params.armed)
            pitch: guardNaN(params.pitch)
            roll: guardNaN(params.roll)

            Indicators.ValueLabel {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -parent.height / 4
                prefixFont.pixelSize: Controls.Theme.auxFontSize * 0.8
                prefix: qsTr("PITCH")
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
                prefix: qsTr("AMSL")
                tipText: qsTr("Altitude above main sea level")
                value: guardNaN(params.altitudeAmsl)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("AREL")
                tipText: qsTr("Altitude relative to HOME position")
                value: guardNaN(params.altitudeRelative)
            }

            Indicators.Text { width: parent.width; text: qsTr("m") }
        }
    }

    Row {
        visible: maximized
        spacing: 0

        Column {
            spacing: Controls.Theme.spacing
            width: root.width / 4

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("HDG")
                tipText: qsTr("Heading")
                value: compas.heading
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("CRS")
                tipText: qsTr("Course")
                value: compas.course
            }

            Indicators.Text { width: parent.width; text: "\u00B0" }
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
                tipText: qsTr("Waypoint distance")
                value: guardNaN(params.wpDistance)
            }

            Indicators.ValueLabel {
                width: parent.width
                prefix: qsTr("HOME")
                tipText: qsTr("Home distance")
                value: guardNaN(params.homeDistance)
            }

            Indicators.Text { width: parent.width; text: qsTr("m") }
        }
    }

    Row {
        spacing: 0

        Controls.ComboBox {
            width: root.width / 8 * 5
            flat: true
            labelText: qsTr("Mode")
            model: params.modes ? params.modes : []
            displayText: params.mode ? params.mode : ""
            onActivated: setParam("setMode", model[index])
        }

        Controls.ComboBox {
            id: wpBox
            width: root.width / 8 * 3
            flat: true
            labelText: qsTr("WP")
            model: params.wpCount ? params.wpCount : 0
            displayText: typeof(params.wp) !== "undefined" ? params.wp : "-"
            Binding on currentIndex { value: params.wp ? params.wp : 0; when: !wpBox.activeFocus}
            onActivated: setParam("setWp", index)
        }
    }
}
