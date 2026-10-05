// Press or release ctrl+opt+F12 as real key events, for Wispr push-to-talk.
// Usage: tinghold down | up | undo   (undo = a real cmd+Z)
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
let cmd: CGKeyCode = 55, z: CGKeyCode = 6
let arg = CommandLine.arguments.dropFirst().first
if arg == "undo" {
    post(cmd, true, .maskCommand)
    usleep(10_000)
    post(z, true, .maskCommand)
    post(z, false, .maskCommand)
    usleep(10_000)
    post(cmd, false, [])
} else if arg == "down" {
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
