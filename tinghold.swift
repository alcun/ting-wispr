// Press or release ctrl+opt+F12 as real key events, for Wispr push-to-talk.
// Usage: tinghold down | up
import CoreGraphics
import Foundation
let ctrl: CGKeyCode = 59, opt: CGKeyCode = 58, f12: CGKeyCode = 111
let src = CGEventSource(stateID: .hidSystemState)
func post(_ code: CGKeyCode, _ down: Bool, _ flags: CGEventFlags) {
    let e = CGEvent(keyboardEventSource: src, virtualKey: code, keyDown: down)!
    e.flags = flags
    e.post(tap: .cghidEventTap)
}
let both: CGEventFlags = [.maskControl, .maskAlternate]
if CommandLine.arguments.dropFirst().first == "down" {
    post(ctrl, true, .maskControl)
    usleep(10_000)
    post(opt, true, both)
    usleep(10_000)
    post(f12, true, both)
} else {
    // Drop both modifiers in one step so nothing sees ctrl alone.
    post(f12, false, both)
    usleep(20_000)
    post(opt, false, [])
    post(ctrl, false, [])
}
