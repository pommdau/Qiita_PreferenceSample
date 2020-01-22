//
//  Defaults.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/22.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Foundation
import Cocoa

class CommentPreferences {
    
    init() {
        UserDefaults.standard.register(defaults: ["strokeWidth": "-4.0"])
    }
    
    
    var font: NSFont {
        get {
            guard let name = UserDefaults.standard.object(forKey: "fontName") as? String else {
                return NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
            
            let size = CGFloat(UserDefaults.standard.float(forKey: "fontSize")) // 登録されていないときは…？
            guard let font = NSFont(name: name, size: size) else {
                return NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
            
            return font
        }
        
        set(font) {
            UserDefaults.standard.set(font.fontName, forKey: "fontName")
            UserDefaults.standard.set(Float(font.pointSize), forKey: "fontSize")
        }
    }
    
    var fontColor: NSColor {
        get {
            guard let colorData = UserDefaults.standard.data(forKey: "fontColor") else {
                return NSColor.black
            }
            guard let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? NSColor else {
                return NSColor.black
            }
            return color
        }
        
        set (color) {
            guard let colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData? else {
                return
            }
            UserDefaults.standard.set(colorData, forKey: "fontColor")
        }
    }
    
    var strokeColor: NSColor {
        get {
            guard let colorData = UserDefaults.standard.data(forKey: "strokeColor") else {
                return NSColor.white
            }
            guard let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? NSColor else {
                return NSColor.white
            }
            return color
        }
        
        set (color) {
            guard let colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData? else {
                return
            }
            UserDefaults.standard.set(colorData, forKey: "strokeColor")
        }
    }
    
    var strokeWidth: Float {
        get {
            let strokeWidth = UserDefaults.standard.float(forKey: "strokeWidth")
            return strokeWidth
        }
        
        set (strokeWidth) {
            UserDefaults.standard.set(strokeWidth, forKey: "strokeWidth")
        }
    }
}
