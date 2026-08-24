import QtQuick
import Quickshell.Io

Item {
  id: root

  // Injected by omarchy-shell (the first-party service loader).
  property var shell: null

  readonly property string script: Qt.resolvedUrl("bin/dynamic-wallpaper").toString().replace(/^file:\/\//, "")

  Process {
    id: apply
    command: [root.script]
  }

  // The script exits early when the wallpaper for this minute is already the
  // current one, so polling every minute is cheap and keeps the last minutes
  // of the hour smooth for the crossfade.
  Timer {
    interval: 60000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: if (!apply.running) apply.running = true
  }
}
