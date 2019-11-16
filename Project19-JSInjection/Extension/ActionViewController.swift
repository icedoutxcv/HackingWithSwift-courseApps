//
//  ActionViewController.swift
//  Extension
//
//  Created by Kamil Bloch on 13/11/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet weak var script: UITextView!
    
    var pagetitle = ""
    var pageURL = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScripts))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pagetitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pagetitle
                        self?.saveWebsite(websitePage: self?.pagetitle ?? "", websiteURL: self?.pageURL ?? "")
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
        
    }
    
    @objc func showScripts() {
        var ac = UIAlertController(title: "Scripts", message: "Choose script to execute", preferredStyle: .actionSheet)
        
        // list
        ac.addAction(UIAlertAction(title: "Show some alert", style: .default) { [weak self] action in
            self?.runJS(fileName: "Alert")
        })
        
        ac.addAction(UIAlertAction(title: "Make BG pink!", style: .default) { [weak self] action in
            self?.runJS(fileName: "PinkBG")
        })
        
        ac.addAction(UIAlertAction(title: "Make BG black!", style: .default) { [weak self] action in
            self?.runJS(fileName: "BlackBG")
        })
        
        ac.addAction(UIAlertAction(title: "Saved pages", style: .default) { [weak self]
            action in
            let savedWebsites = self?.showSavedWebsites().description
            ac.dismiss(animated: true)
            ac = UIAlertController(title: "Saved websites", message: savedWebsites, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(ac, animated: true)
        })
            
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func runJS(fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "js") else { return }  // file path for file "data.txt"
        guard let code = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else { return }
        script.text = code
        done()
    }
    
    func saveWebsite(websitePage: String, websiteURL: String) {
        if !websitePage.isEmpty && !websiteURL.isEmpty {
            if UserDefaults.standard.object(forKey: websiteURL) == nil {
                    UserDefaults.standard.set([websitePage, websiteURL], forKey: websiteURL)
                    
            }
        }
    }
    
    func showSavedWebsites() -> [String] {
        var data = [String]()
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
            
            if key.contains("www") {
                data.append(key)
            }
        }
        return data
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
 
}
