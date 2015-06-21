import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
  // XXX make it configurable
  property int max_rate: 4000
  property int fontPx: 7
  property string ifname: "wlp2s0"
  property string border_color: "#00FFFFFF"
  property string xmit_color_low: "#7BC2D5"
  property string xmit_color_high: "#FFFF00"
  property string recv_color_low: "#88D57A"
  property string recv_color_high: "#FFFF00"
  
  property string recv_rate
  property string xmit_rate
  
  Plasmoid.compactRepresentation: Representation {}
  Plasmoid.fullRepresentation: Representation {}

  PlasmaCore.DataSource {
    id: datasource
    engine: "systemmonitor"
    connectedSources: ["network/interfaces/"+ifname+"/receiver/data","network/interfaces/"+ifname+"/transmitter/data"]
    interval: 500
    
    onNewData: {
      //console.warn(JSON.stringify(data))
      if (sourceName.match(/transmitter/))
        xmit_rate = data['value']
      else
        recv_rate = data['value']
    }
  }
}
