//
//  AdvancedPreferences.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/24.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Foundation
import Cocoa

class AdvancedPreferences {
    
    enum UserDefaultsKey: String {
        case fontName
        case fontSize
        case fontColor
        case strokeColor
        case strokeWidth
        case opacity
    }
    
    init() {
        // NSColorに関してはGetterの処理に任せている
        UserDefaults.standard.register(defaults: [UserDefaultsKey.fontName.rawValue : "HiraginoSans-W7",
                                                  UserDefaultsKey.fontSize.rawValue : 44.0,
                                                  UserDefaultsKey.strokeWidth.rawValue : 2.0,
                                                  UserDefaultsKey.opacity.rawValue : 1.0])
    }
    
    // For Debug
    func resetUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.fontName.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.fontSize.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.fontColor.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.strokeColor.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.strokeWidth.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.opacity.rawValue)
    }
    
    
    var font: NSFont {
        get {
            guard let name = UserDefaults.standard.object(forKey: UserDefaultsKey.fontName.rawValue) as? String else {
                return NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
            
            let size = CGFloat(UserDefaults.standard.float(forKey: UserDefaultsKey.fontSize.rawValue)) // 登録されていないときは…？
            guard let font = NSFont(name: name, size: size) else {
                return NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
            return font
        }
        
        set(font) {
            UserDefaults.standard.set(font.fontName, forKey: UserDefaultsKey.fontName.rawValue)
            UserDefaults.standard.set(Float(font.pointSize), forKey: UserDefaultsKey.fontSize.rawValue)
        }
    }
    
    var fontColor: NSColor {
        get {
            guard let colorData = UserDefaults.standard.data(forKey: UserDefaultsKey.fontColor.rawValue) else {
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
            UserDefaults.standard.set(colorData, forKey: UserDefaultsKey.fontColor.rawValue)
        }
    }
    
    var strokeColor: NSColor {
        get {
            guard let colorData = UserDefaults.standard.data(forKey: UserDefaultsKey.strokeColor.rawValue) else {
                return NSColor.blue
            }
            guard let color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? NSColor else {
                return NSColor.blue
            }
            return color
        }
        
        set (color) {
            guard let colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData? else {
                return
            }
            UserDefaults.standard.set(colorData, forKey: UserDefaultsKey.strokeColor.rawValue)
        }
    }
    
    var strokeWidth: Float {
        get {
            let strokeWidth = UserDefaults.standard.float(forKey: UserDefaultsKey.strokeWidth.rawValue)
            return strokeWidth
        }
        
        set (strokeWidth) {
            UserDefaults.standard.set(strokeWidth, forKey: UserDefaultsKey.strokeWidth.rawValue)
        }
    }
    
    var opacity: Float {
        get {
            let opacity = UserDefaults.standard.float(forKey: UserDefaultsKey.opacity.rawValue)
            return opacity
        }
        
        set (opacity) {
            UserDefaults.standard.set(opacity, forKey: UserDefaultsKey.opacity.rawValue)
        }
    }
}
