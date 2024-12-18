import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

Item {
    id: root

    property real hue : 1
    property real saturation : 1

    signal updateHS(var hueSignal, var saturationSignal)
    signal updateColor()

    states: [
        State {
            name: "editing"
            PropertyChanges {
                target: root
                hue: hue
                saturation: saturation
            }
        },
        State {
            name: "normal"
        }
    ]
    state: "normal"

    Rectangle {
        id: rgbColorCircle

        anchors.fill: parent
        color: "transparent"

        // ShaderEffect {
        //     id: shader

        //     anchors.fill: parent
        //     vertexShader: "
        //         uniform highp mat4 qt_Matrix;
        //         attribute highp vec4 qt_Vertex;
        //         attribute highp vec2 qt_MultiTexCoord0;
        //         varying highp vec2 coord;

        //         void main()
        //         {
        //             coord = qt_MultiTexCoord0 - vec2(0.5, 0.5);
        //             gl_Position = qt_Matrix * qt_Vertex;
        //         }"
        //     fragmentShader: "
        //         varying highp vec2 coord;

        //         vec3 hsv2rgb(in vec3 c)
        //         {
        //             vec4 k = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
        //             vec3 p = abs(fract(c.xxx + k.xyz) * 6.0 - k.www);
        //             return c.z * mix(k.xxx, clamp(p - k.xxx, 0.0, 1.0), c.y);
        //         }

        //         void main()
        //         {
        //             const float PI = 3.14159265358979323846264;
        //             float s = sqrt(coord.x * coord.x + coord.y * coord.y);

        //             if( s > 0.5 )
        //             {
        //                 gl_FragColor = vec4(0, 0, 0, 0);
        //                 return;
        //             }

        //             float h = - atan( coord.y / coord.x );
        //             s *= 2.0;

        //             if( coord.x >= 0.0 )
        //             {
        //                 h += PI;
        //             }

        //             h = h / (2.0 * PI);
        //             vec3 hsl = vec3(h, s, 1.0);
        //             vec3 rgb = hsv2rgb(hsl);
        //             gl_FragColor.rgb = rgb;
        //             gl_FragColor.a = 1.0;
        //         }"
        // }

        Image {
            height: parent.height + 2
            width: parent.width + 2
            anchors.centerIn: parent
            source: "../assets/RGBAColor.png"
        }

        Rectangle {
            id: colorPicker
            property int r : 8

            x: parent.width/2 * (1 + root.saturation * Math.cos(2 * Math.PI * root.hue - Math.PI)) - r
            y: parent.width/2 * (1 + root.saturation * Math.sin(-2 * Math.PI * root.hue - Math.PI)) - r
            height: 22.5
            width: 22.5
            radius: width
            color: "transparent"
            border {
                color: "white"
                width: 1.5
            }
        }

        MouseArea {
            id : colorCircleArea
            // Keep cursor in colorCircleArea
            function keepCursorIncolorCircleArea(mouse, colorCircleArea, colorCircleArea) {
                root.state = 'editing'
                if (mouse.buttons & Qt.LeftButton) {
                    // cartesian to polar coords
                    var distance = Math.sqrt(Math.pow(mouse.x-colorCircleArea.width/2,2)+Math.pow(mouse.y-colorCircleArea.height/2,2));
                    var theta = Math.atan2(((mouse.y-colorCircleArea.height/2)*(-1)),((mouse.x-colorCircleArea.width/2)));

                    // colorCircleArea limit
                    if(distance > colorCircleArea.width/2)
                        distance = colorCircleArea.width/2;

                    // polar to cartesian coords
                    var cursor = Qt.vector2d(0, 0);
                    cursor.x = Math.max(-colorPicker.r, Math.min(colorCircleArea.width, distance*Math.cos(theta)+colorCircleArea.width/2)-colorPicker.r);
                    cursor.y = Math.max(-colorPicker.r, Math.min(colorCircleArea.height, colorCircleArea.height/2-distance*Math.sin(theta)-colorPicker.r));

                    hue = Math.ceil((Math.atan2(((cursor.y+colorPicker.r-colorCircleArea.height/2)*(-1)),((cursor.x+colorPicker.r-colorCircleArea.width/2)))/(Math.PI*2)+0.5)*100)/100
                    saturation = Math.ceil(Math.sqrt(Math.pow(cursor.x+colorPicker.r-width/2,2)+Math.pow(cursor.y+colorPicker.r-height/2,2))/colorCircleArea.height*2*100)/100;
                    root.updateHS(hue, saturation) ;
                }
            }
            anchors.fill: parent

            onPositionChanged: {
                root.updateColor()
                keepCursorIncolorCircleArea(mouse, colorCircleArea,  colorCircleArea);
            }

            onPressed: {
                root.updateColor()
                keepCursorIncolorCircleArea(mouse, colorCircleArea, colorCircleArea);
            }

            onReleased: {
                root.state = 'normal'
            }
        }
    }
}
