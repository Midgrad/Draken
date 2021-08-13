import QtQuick 2.6
import Industrial.Controls 1.0 as Controls
import Industrial.Indicators 1.0 as Indicators
import Dreka.Draken 1.0

Column {
    id: root

    spacing: 0

    Indicators.Text { text: qsTr("STATE: -") }

    Indicators.AttitudeDirector {
        id: ai
        width: parent.width
    }

    Indicators.Compass {
        id: compas
        width: parent.width
    }
}
