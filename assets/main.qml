/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2

Page {

    property bool running: false
    property int currentExercise: -1

    function nextExercise() {
        if (currentExercise <= 0) {
            currentExercise = 1
            label_30.start();
        } else if (currentExercise > 8) {
            currentExercise = -1
        } else {
            currentExercise ++;
            label_30.start();
        }
    }

    Container {

        Container {

            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center

            ImageView {
                
                property string imageStr: ""
                
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center

                id: exerciseImage
                
                visible: imageStr != ""
                
                imageSource: "asset:///images/" + imageStr
                scalingMethod: ScalingMethod.AspectFit
                maxWidth: 400
            }

            CountdownLabel {
                id: label_starting
                time: 10
                //time: 2
                onStarted: {
                    exerciseImage.imageStr = "1.png"
                }
                onFinished: {
                    nextExercise();
                }
            }

            CountdownLabel {
                id: label_30
                time: 30
                //time: 5
                onFinished: {
                    if (currentExercise < 8) {
                        label_15.start();
                    } else {
                        label_2_min.start();
                    }
                }
            }

			Label {
       
       			visible: label_15.visible
       			text: "Coming up..."
       			textStyle.base: SystemDefaults.TextStyles.BigText
       		}
				
            CountdownLabel {
                id: label_15
                time: 15
                //time: 3
                onStarted: {
                    exerciseImage.imageStr = (currentExercise + 1 ) + ".png"
                }
                onFinished: {
                    nextExercise();
                }
            }

            CountdownLabel {
                id: label_2_min
                time: 120
               // time: 7
                onStarted: {
                    exerciseImage.visible = false
                }
                onFinished: {
                    running = false;
                }
            }

            Button {
                visible: ! running
                text: "Start"
                onClicked: {
                    running = true;
                    label_starting.start()
                }
            }
        }

    }
}
