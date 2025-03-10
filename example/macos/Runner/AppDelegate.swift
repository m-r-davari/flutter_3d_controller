import Cocoa
import FlutterMacOS
import flutter_inappwebview_macos

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}

extension InAppWebView {
    @objc public override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        if window != nil {
            print("InAppWebView moved to window, enforcing transparency")
            self.setValue(false, forKey: "opaque")
            self.setValue(false, forKey: "drawsBackground")
            self.layer?.backgroundColor = NSColor.clear.cgColor
        }
    }
}