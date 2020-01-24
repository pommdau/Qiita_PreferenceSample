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
    
    // TODO: Setting Default Value
    init() {
        UserDefaults.standard.register(defaults: ["": ""])
    }
    
    var message: String {
        get {
            guard let message = UserDefaults.standard.string(forKey: "GEP_message") else {
                return "いろはにほへと　ちりぬるを"
            }
            
            return message
        }
        
        set(message) {
            UserDefaults.standard.set(message, forKey: "GEP_message")
        }
    }
}
