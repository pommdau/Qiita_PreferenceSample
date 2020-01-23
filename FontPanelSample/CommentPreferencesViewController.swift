//
//  CommentPreferencesViewController.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/23.
//  Copyright © 2020年 hikeuchi. All rights reserved.
// TODO:set saved fbont on fontPanel

import Cocoa

class CommentPreferencesViewController: NSViewController {
    
    @IBOutlet weak var fontNameTextField: NSTextField!
    @IBOutlet var fontColorWell: NSColorWell!
    @IBOutlet var strokeColorWell: NSColorWell!
    @IBOutlet var strokeWidthTextField: NSTextField!
    @IBOutlet var strokeWidthStepper: NSStepper!
    
    let commentPreferences = CommentPreferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fontNameTextField.stringValue = String(format: "%@ %d", commentPreferences.font.fontName, Int(commentPreferences.font.pointSize))
        fontColorWell.color = commentPreferences.fontColor
        strokeColorWell.color = commentPreferences.strokeColor
        strokeWidthTextField.stringValue = String(format: "%.1f", commentPreferences.strokeWidth)
        strokeWidthStepper.floatValue = commentPreferences.strokeWidth
        
        commentPreferencesChanged()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func fontPanelButtonClicked(_ sender: Any) {
        let fontManager = NSFontManager.shared
        fontManager.target = self
        let panel = fontManager.fontPanel(true)
        panel?.orderFront(self)
        panel?.isEnabled = true // trueをセットすると使用可能になります（今回は無くても良い？）
    }
    
    func commentPreferencesChanged() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "CommnetPreferencesChanged"), object: nil)
        
    }
    
    @IBAction func changeFontColor(_ sender: Any) {
        guard let colorWell = sender as? NSColorWell else {
            return
        }
        if (colorWell.identifier!.rawValue == "FontColorWell") {
            commentPreferences.fontColor = colorWell.color
        } else if (colorWell.identifier!.rawValue == "StrokeColorWell") {
            commentPreferences.strokeColor = colorWell.color
        }
        commentPreferencesChanged()
    }
    
    @IBAction func strokeWidthChanged(_ sender: NSTextField) {
        var strokeWidth = sender.floatValue // 変換できない場合は0.0が帰ってくる
        
        if strokeWidth < 0.0 || strokeWidth > 100.0 {
            strokeWidth = 0.0
        }
        
        if strokeWidth == 0.0 {
            sender.stringValue = "0.0"
        }
        
        commentPreferences.strokeWidth = strokeWidth
        strokeWidthStepper.floatValue = strokeWidth
        commentPreferencesChanged()
    }
    
    @IBAction func strokeWidthStepperClicked(_ sender: NSStepper) {
        let strokeWidth = sender.floatValue
        commentPreferences.strokeWidth = strokeWidth
        strokeWidthTextField.stringValue = String(format: "%.1f", strokeWidth)
        commentPreferencesChanged()
    }
}

extension CommentPreferencesViewController : NSFontChanging {
    func changeFont(_ sender: NSFontManager?) {
        guard let fontManager = sender else {
            return
        }
        let newFont = fontManager.convert(commentPreferences.font)
        commentPreferences.font = newFont
        fontNameTextField.stringValue = String(format: "%@ %d", commentPreferences.font.fontName, Int(commentPreferences.font.pointSize))
        commentPreferencesChanged()
    }
}

