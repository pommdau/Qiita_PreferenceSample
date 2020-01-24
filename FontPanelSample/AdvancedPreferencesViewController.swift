//
//  AdvancedPreferencesViewController.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/24.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Cocoa

class AdvancedPreferencesViewController: NSViewController {
    
    @IBOutlet weak var fontNameTextField: NSTextField!
    @IBOutlet var fontColorWell: NSColorWell!
    @IBOutlet var strokeColorWell: NSColorWell!
    @IBOutlet var strokeWidthTextField: NSTextField!
    @IBOutlet var strokeWidthStepper: NSStepper!
    @IBOutlet var alphaSlider: NSSlider!
    @IBOutlet var alphaTextField: NSTextField!
    
    let commentPreferences = CommentPreferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fontNameTextField.stringValue = String(format: "%@ %d", commentPreferences.font.fontName, Int(commentPreferences.font.pointSize))
        fontColorWell.color = commentPreferences.fontColor
        strokeColorWell.color = commentPreferences.strokeColor
        strokeWidthTextField.stringValue = String(format: "%.1f", commentPreferences.strokeWidth)
        strokeWidthStepper.floatValue = commentPreferences.strokeWidth
        alphaSlider.doubleValue = Double(commentPreferences.fontColor.alphaComponent)
        alphaTextField.doubleValue = Double(commentPreferences.fontColor.alphaComponent)
        
        commentPreferencesChanged()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func showFontPanel(_ sender: Any) {
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
        } else {
            sender.stringValue = String(format: "%.1f", strokeWidth)
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
    
    @IBAction func alphaSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? NSSlider else {
            return
        }
        
        let alpha = slider.doubleValue
        alphaTextField.doubleValue = alpha
        commentPreferences.fontColor = commentPreferences.fontColor.withAlphaComponent(CGFloat(alpha))
        commentPreferences.strokeColor = commentPreferences.strokeColor.withAlphaComponent(CGFloat(alpha))
        
        commentPreferencesChanged()
    }
    
    @IBAction func alphaTextFieldValueChanged(_ sender: Any) {
        // todo インプット確認
        
        let alpha = alphaTextField.doubleValue
        print("\(alpha)")
        alphaSlider.doubleValue = alpha
        
        commentPreferences.fontColor = commentPreferences.fontColor.withAlphaComponent(CGFloat(alpha))
        commentPreferences.strokeColor = commentPreferences.strokeColor.withAlphaComponent(CGFloat(alpha))
        
        commentPreferencesChanged()
    }
    
}

extension AdvancedPreferencesViewController : NSFontChanging {
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

