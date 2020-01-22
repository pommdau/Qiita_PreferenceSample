//
//  ViewController.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/22.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var fontNameTextField: NSTextField!
    var commentPreferences = CommentPreferences()
    @IBOutlet var outputLabel: NSTextField!
    @IBOutlet var fontColorWell: NSColorWell!
    @IBOutlet var strokeColorWell: NSColorWell!
    @IBOutlet var strokeWidthTextField: NSTextField!
    @IBOutlet var strokeWidthStepper: NSStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outputLabel.font = commentPreferences.font
        fontNameTextField.stringValue = "\(commentPreferences.font.fontName) \(commentPreferences.font.pointSize)"
        fontColorWell.color = commentPreferences.fontColor
        strokeColorWell.color = commentPreferences.strokeColor
        strokeWidthTextField.stringValue = String(format: "%.1f", commentPreferences.strokeWidth)
        strokeWidthStepper.floatValue = commentPreferences.strokeWidth
        
        
        updateOutputLabel()
        
        fontPanelButtonClicked(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func fontPanelButtonClicked(_ sender: Any) {
        NSFontPanel.shared.makeKeyAndOrderFront(self)
    }
    
    func updateOutputLabel() {
        
        let stringAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : commentPreferences.fontColor,
            .font : NSFont(name: commentPreferences.font.fontName, size: commentPreferences.font.pointSize)
                ?? NSFont.boldSystemFont(ofSize: CGFloat(24)),
            .strokeColor : commentPreferences.strokeColor,
            .strokeWidth : -commentPreferences.strokeWidth
        ]
        
        let attibutesString = NSAttributedString(string: outputLabel.stringValue,
                                                 attributes: stringAttributes)
        outputLabel.attributedStringValue = attibutesString
        outputLabel.becomeFirstResponder()
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
        updateOutputLabel()
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
        updateOutputLabel()
    }
    
    @IBAction func strokeWidthStepperClicked(_ sender: NSStepper) {
        let strokeWidth = sender.floatValue
        commentPreferences.strokeWidth = strokeWidth
        strokeWidthTextField.stringValue = String(format: "%.1f", strokeWidth)
        updateOutputLabel()
    }
}

extension ViewController : NSFontChanging {
    func changeFont(_ sender: NSFontManager?) {
        guard let fontManager = sender else {
            return
        }
        let newFont = fontManager.convert(commentPreferences.font)
        commentPreferences.font = newFont
        fontNameTextField.stringValue = "\(commentPreferences.font.fontName) \(commentPreferences.font.pointSize)"
        updateOutputLabel()
    }
}
