import bb.cascades 1.2
import Timer 1.0

Container {

    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Center

	visible: countdownLabel.text != ""

    property int time: -1
    property bool running: false

	signal started
    signal finished

    function start() {
        if (! running && time >= 0) {
            
            started();
            
            running = true;

            countdownLabel.labelCount = time;
            timer.start();

        }
    }

    attachedObjects: [
        QTimer {
            id: timer
            interval: 1000
            onTimeout: {
                if (countdownLabel.labelCount > 0) {
                    countdownLabel.labelCount --;
                } else {
                    timer.stop();
                    running = false;
                    finished();
                }
            }
        }
    ]

    Label {



        property int labelCount: -1

        id: countdownLabel
        text: "" + (labelCount > 0 ? labelCount : "")
        textStyle {
            fontSize: FontSize.PointValue
            fontSizeValue: 50
        }
    }

}
