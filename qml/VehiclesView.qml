import QtQuick 2.6
import QtQuick.Layouts 1.12
import Industrial.Controls 1.0 as Controls
import Industrial.Widgets 1.0 as Widgets
import Dreka.Draken 1.0

Controls.Pane {
    id: root

    padding: Controls.Theme.margins

    VehiclesController {
        id: controller
    }

    Component.onCompleted: controller.start()

    ColumnLayout {
        anchors.fill: parent
        spacing: Controls.Theme.spacing

        RowLayout {
            spacing: Controls.Theme.spacing

            Controls.ComboBox {
                id: vehiclesBox
                flat: true
                model: controller.vehicles
                labelText: qsTr("Vehicles")
            }

            Controls.Button {
                flat: true
                round: true
                iconSource: "qrc:/icons/up.svg"
            }
        }

        GenericDashboard {
            vehicle: vehiclesBox.currentText
            Layout.fillWidth: true
        }
    }
}

