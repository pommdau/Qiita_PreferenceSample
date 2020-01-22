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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outputLabel.font = commentPreferences.font
        fontNameTextField.stringValue = "\(commentPreferences.font.fontName) \(commentPreferences.font.pointSize)"
        fontColorWell.color = commentPreferences.fontColor
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
            .strokeColor : NSColor.black,
            .strokeWidth : -2.0
        ]
        
        let attibutesString = NSAttributedString(string: outputLabel.stringValue,
                                                 attributes: stringAttributes)
        outputLabel.attributedStringValue = attibutesString
    }
    
    @IBAction func changeFontColor(_ sender: Any) {
        guard let colorWell = sender as? NSColorWell else {
            return
        }
        if (colorWell.identifier!.rawValue == "FontColorWell") {
            commentPreferences.fontColor = colorWell.color
        } else if (colorWell.identifier!.rawValue == "StrokeColorWell") {
            print("\(colorWell.color)")
        }
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
