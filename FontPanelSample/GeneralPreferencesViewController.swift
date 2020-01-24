//
//  GeneralPreferencesViewController.swift
//  FontPanelSample
//
//  Created by HIROKI IKEUCHI on 2020/01/24.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Cocoa

class GeneralPreferencesViewController: NSViewController {

    @IBOutlet var messageTextField: NSTextField!
    
    let generalPreferences = GeneralPreferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.stringValue = generalPreferences.message
    }

    func generalPreferencesChanged() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "GeneralPreferencesChanged"), object: nil)
    }
    
    @IBAction func messageChanged(_ sender: Any) {
        guard let messageTextField = sender as? NSTextField else {
            return
        }
        generalPreferences.message = messageTextField.stringValue
        
        generalPreferencesChanged()
    }
}

