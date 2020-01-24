//
//  PreferencesWindow.swift
//  FontPanelSample
//
//  Created by Hiroki Ikeuchi on 2020/01/23.
//  Copyright © 2020 hikeuchi. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSPanel {
    
    // MARK: Panel Methods
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        switch menuItem.action {
        case #selector(toggleToolbarShown(_:))?:
            return false
        default:
            return super.validateMenuItem(menuItem)
        }
    }
}
