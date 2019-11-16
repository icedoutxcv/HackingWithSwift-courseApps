//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by icedoutxcv on 10/03/2019.
//  Copyright © 2019 icedoutxcv. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedImage: String?
    var customTitle: String?
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        title = customTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.hidesBarsOnTap = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    

}
