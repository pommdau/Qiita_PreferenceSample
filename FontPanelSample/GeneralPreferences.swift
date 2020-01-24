//
//  GeneralPreferences.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/24.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Foundation
import Cocoa

class GeneralPreferences {
    
    enum UserDefaultsKey: String {
        case message
    }
    
    init() {
        UserDefaults.standard.register(defaults: [UserDefaultsKey.message.rawValue: "いろはにほへと　ちりぬるを"])
    }
    
    // For Debug
    func resetUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.message.rawValue)
    }
    
    var message: String {
        get {
            guard let message = UserDefaults.standard.string(forKey: UserDefaultsKey.message.rawValue) else {
                return ""
            }
            
            return message
        }
        
        set(message) {
            UserDefaults.standard.set(message, forKey: UserDefaultsKey.message.rawValue)
        }
    }
}
