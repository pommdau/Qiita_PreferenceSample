//
//  PreferencesTabViewController.swift
//  FontPanelSample
//
//  Created by Hiroki Ikeuchi on 2020/01/23.
//  Copyright © 2020 hikeuchi. All rights reserved.
//

import Cocoa

class PreferencesTabViewController: NSTabViewController {
    
    // MARK: Tab View Controller Methods
    
    override var selectedTabViewItemIndex: Int {
        didSet {
            // avoid storing initial state (set in the story board) -> self.isViewLoadedの所？
            if
                self.isViewLoaded,
                let identifier = self.tabViewItems[selectedTabViewItemIndex].identifier as? String
            {
                UserDefaults.standard.set(identifier, forKey: "lastPreferencesPanelIdentifier")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // select last used pane
        if
            let identifier = UserDefaults.standard.string(forKey: "lastPreferencesPanelIdentifier"),
            let item = self.tabViewItems.enumerated().first(where: { ($0.element.identifier as? String) == identifier })
        {
            print("\(item.offset)")
            self.selectedTabViewItemIndex = item.offset // 最後に開いたタブを選択状態とする
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window!.title = self.tabViewItems[selectedTabViewItemIndex].label // ウィンドウタイトルを決定する（設定ウィンドウを新規に開く場合）
    }
    
    override func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, willSelect: tabViewItem)
        
        guard let tabViewItem = tabViewItem else { return assertionFailure() }
        self.switchPane(to: tabViewItem)
    }
    
    
    
    // MARK: Private Methods
    
    // resize window to fit to new view
    private func switchPane(to tabViewItem: NSTabViewItem) {
        // 開く予定のTabViewのFrame
        guard let viewFrame = tabViewItem.view?.frame else { return assertionFailure() }
        
        // initialize tabView's frame size
        guard let window = self.view.window else {
            // 設定ウィンドウを新規に開く場合、「self.view.window = PreferencesWindow」がまだないので以下の処理とする
            self.view.frame = viewFrame // 単純に開く予定のTabViewのFrameでOK
            return
        }

        // calculate window frame
        var frame = window.frameRect(forContentRect: viewFrame) // 開く予定のウィンドウのFrame
        frame.origin = window.frame.origin
        frame.origin.y += window.frame.height - frame.height

        // apply to window
        self.view.isHidden = true   // ウィンドウサイズが決定したあとに内容を表示する
        NSAnimationContext.runAnimationGroup({ _ in
            print("\(frame)")
            window.animator().setFrame(frame, display: false)
        }, completionHandler: { [weak self] in
            self?.view.isHidden = false
            window.title = tabViewItem.label
        })
        
    }
    
}
