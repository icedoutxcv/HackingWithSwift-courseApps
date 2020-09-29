//
//  DetailViewController.swift
//  Project38 GithubCommits
//
//  Created by icedoutxcv on 26/09/2020.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

//    @IBOutlet weak var detailLabel: UILabel!
    var detailItem: Commit?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let detail = self.detailItem {
//            detailLabel.text = detail.message
//        }
        loadPage()
        
        
    }
    
    
    func loadPage() {
        let link = URL(string: detailItem!.url)
        let request = URLRequest(url: link!)
        webView.load(request)
        print("end")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
