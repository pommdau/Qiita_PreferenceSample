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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        outputLabel.font = commentPreferences.font
        fontNameTextField.stringValue = "\(commentPreferences.font.fontName) \(commentPreferences.font.pointSize)"
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
        outputLabel.font = commentPreferences.font
        
    }
    
}

extension ViewController :NSFontChanging {
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
