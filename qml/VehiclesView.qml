import QtQuick 2.6
import QtQuick.Layouts 1.12
import Industrial.Controls 1.0 as Controls
import Industrial.Widgets 1.0 as Widgets
import Dreka.Draken 1.0

Controls.Pane {
    id: root

    property bool maximized: true

    padding: Controls.Theme.margins

    VehiclesController { id: controller }

    Component.onCompleted: {
        map.registerController("vehiclesController", controller)
        timer.start();
    }

    Timer {
        id: timer
        interval: 1500;
        onTriggered: controller.test()
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Controls.Theme.spacing

        RowLayout {
            spacing: Controls.Theme.spacing

            Controls.ComboBox {
                id: vehiclesBox
                flat: true
                model: controller.vehicles
                labelText: qsTr("Vehicle")
            }

            Controls.Button {
                flat: true
                round: true
                tipText: maximized ? qsTr("Minimize") : qsTr("Maximize")
                iconSource: maximized ? "qrc:/icons/up.svg" : "qrc:/icons/down.svg"
                onClicked: maximized = !maximized
            }
        }

        GenericDashboard {
            vehicle: vehiclesBox.displayText
            Layout.fillWidth: true
        }
    }
}

