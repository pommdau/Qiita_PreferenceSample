//
//  ViewController.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/22.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let advancedPreferences = AdvancedPreferences()
    let generalPreferences = GeneralPreferences()
    @IBOutlet var outputTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定ウィンドウからの通知を受け取る設定
        let notificationNames = [Notification.Name(rawValue: "AdvancedPreferencesChanged"),
                                 Notification.Name(rawValue: "GeneralPreferencesChanged")]
        
        for notificationName in notificationNames {
            NotificationCenter.default.addObserver(forName: notificationName,
                                                   object: nil,
                                                   queue: nil) {
                                                    (notification) in
                                                    self.updateOutputTextField()
            }
        }
        outputTextField.wantsLayer = true   // for changing opacity
        updateOutputTextField()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func updateOutputTextField() {
        outputTextField.stringValue = generalPreferences.message
        
        let stringAttributes: [NSAttributedString.Key : Any] = [
            .font : NSFont(name: advancedPreferences.font.fontName, size: advancedPreferences.font.pointSize)
                ?? NSFont.boldSystemFont(ofSize: CGFloat(24)),
            .foregroundColor : advancedPreferences.fontColor,
            .strokeColor : advancedPreferences.strokeColor,
            .strokeWidth : -advancedPreferences.strokeWidth
        ]
        
        let attibutesString = NSAttributedString(string: outputTextField.stringValue,
                                                 attributes: stringAttributes)
        outputTextField.attributedStringValue = attibutesString
        outputTextField.layer?.opacity = advancedPreferences.opacity
    }
    
}
