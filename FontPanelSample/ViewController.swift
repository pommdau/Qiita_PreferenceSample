//
//  ViewController.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/22.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//
// TODO:set saved fbont on fontPanel

import Cocoa

class ViewController: NSViewController {
    
    let commentPreferences = CommentPreferences()
    @IBOutlet var outputTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name(rawValue: "CommnetPreferencesChanged")
        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: nil,
                                               queue: nil) {
                                                (notification) in
                                                self.updateOutputTextField()
        }
        updateOutputTextField()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func updateOutputTextField() {
        let stringAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : commentPreferences.fontColor,
            .font : NSFont(name: commentPreferences.font.fontName, size: commentPreferences.font.pointSize)
                ?? NSFont.boldSystemFont(ofSize: CGFloat(24)),
            .strokeColor : commentPreferences.strokeColor,
            .strokeWidth : -commentPreferences.strokeWidth
        ]
        
        let attibutesString = NSAttributedString(string: outputTextField.stringValue,
                                                 attributes: stringAttributes)
        outputTextField.attributedStringValue = attibutesString
    }
    
}
