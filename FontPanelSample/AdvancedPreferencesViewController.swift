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
    
    let advancedPreferences = AdvancedPreferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fontNameTextField.stringValue = String(format: "%@ %d", advancedPreferences.font.fontName, Int(advancedPreferences.font.pointSize))
        fontColorWell.color = advancedPreferences.fontColor
        strokeColorWell.color = advancedPreferences.strokeColor
        strokeWidthTextField.stringValue = String(format: "%.1f", advancedPreferences.strokeWidth)
        strokeWidthStepper.floatValue = advancedPreferences.strokeWidth
        alphaSlider.doubleValue = Double(advancedPreferences.fontColor.alphaComponent)
        alphaTextField.doubleValue = Double(advancedPreferences.fontColor.alphaComponent)
        
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
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AdvancedPreferencesChanged"), object: nil)
        
    }
    
    @IBAction func changeFontColor(_ sender: Any) {
        guard let colorWell = sender as? NSColorWell else {
            return
        }
        if (colorWell.identifier!.rawValue == "FontColorWell") {
            advancedPreferences.fontColor = colorWell.color
        } else if (colorWell.identifier!.rawValue == "StrokeColorWell") {
            advancedPreferences.strokeColor = colorWell.color
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
        
        advancedPreferences.strokeWidth = strokeWidth
        strokeWidthStepper.floatValue = strokeWidth
        commentPreferencesChanged()
    }
    
    @IBAction func strokeWidthStepperClicked(_ sender: NSStepper) {
        let strokeWidth = sender.floatValue
        advancedPreferences.strokeWidth = strokeWidth
        strokeWidthTextField.stringValue = String(format: "%.1f", strokeWidth)
        commentPreferencesChanged()
    }
    
    @IBAction func alphaSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? NSSlider else {
            return
        }
        
        let alpha = slider.doubleValue
        alphaTextField.doubleValue = alpha
        advancedPreferences.fontColor = advancedPreferences.fontColor.withAlphaComponent(CGFloat(alpha))
        advancedPreferences.strokeColor = advancedPreferences.strokeColor.withAlphaComponent(CGFloat(alpha))
        
        commentPreferencesChanged()
    }
    
    @IBAction func alphaTextFieldValueChanged(_ sender: Any) {
        // todo インプット確認
        
        let alpha = alphaTextField.doubleValue
        print("\(alpha)")
        alphaSlider.doubleValue = alpha
        
        advancedPreferences.fontColor = advancedPreferences.fontColor.withAlphaComponent(CGFloat(alpha))
        advancedPreferences.strokeColor = advancedPreferences.strokeColor.withAlphaComponent(CGFloat(alpha))
        
        commentPreferencesChanged()
    }
    
}

extension AdvancedPreferencesViewController : NSFontChanging {
    func changeFont(_ sender: NSFontManager?) {
        guard let fontManager = sender else {
            return
        }
        let newFont = fontManager.convert(advancedPreferences.font)
        advancedPreferences.font = newFont
        fontNameTextField.stringValue = String(format: "%@ %d", advancedPreferences.font.fontName, Int(advancedPreferences.font.pointSize))
        commentPreferencesChanged()
    }
}

