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
    var font: NSFont {
        get {
            guard let name = UserDefaults.standard.object(forKey: "fontName") as? String else {
                return NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
            
            let size = CGFloat(UserDefaults.standard.float(forKey: "fontSize")) // 登録されていないときは
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
}
