import QtQuick 2.0

Rectangle {
  color: border_color
  border.width: 1

  Row {
    id: ifBars
    width: parent.width - 2
    height: parent.height
    x: 1

    function calculateHeight(rate) {
      return Math.min(parent.height * rate / max_rate + 1, parent.height);
    }

    Rectangle {
      width: parent.width / 2
      height: ifBars.calculateHeight(xmit_rate)
      anchors.bottom: parent.bottom
      gradient: Gradient {
        GradientStop { position: 0; color: xmit_color_low }
        GradientStop { position: max_rate / xmit_rate; color: xmit_color_high }
      }
      //Behavior on height { SmoothedAnimation { velocity: 200 } }
    }
    Rectangle {
      width: parent.width / 2
      height: ifBars.calculateHeight(recv_rate)
      anchors.top: parent.top
      gradient: Gradient {
        GradientStop { position: 0; color: recv_color_low }
        GradientStop { position: max_rate / recv_rate; color: recv_color_high }
      }
      //Behavior on height { SmoothedAnimation { velocity: 200 } }
    }
  }
  
  function textAlignMode() {
    return parent.width < fontPx*4*2
  }
  
  Text {
    text: xmit_rate
    font.pixelSize: fontPx
    width: textAlignMode() ? parent.width : parent.width / 2 * 0.9
    horizontalAlignment: textAlignMode() ? Text.AlignLeft : Text.AlignRight
  }
  Text {
    text: recv_rate
    y: parent.height - fontPx
    x: textAlignMode() ? 0 : parent.width / 2
    width: textAlignMode() ? parent.width : parent.width / 2 * 0.9
    horizontalAlignment: Text.AlignRight
    font.pixelSize: fontPx
  }
}
