//
//  ViewController.swift
//  Storm Viewer
//
//  Created by icedoutxcv on 10/03/2019.
//  Copyright © 2019 icedoutxcv. All rights reserved.
//

import UIKit

class TableViewController: UICollectionViewController {
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareWithFriends))
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                let picture = Picture(title: item, image: "x")
                pictures.append(picture)
            }
            
        }
        //pictures = pictures.sorted { $0 < $1 }
        print(pictures)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureCell
        cell.title = pictures[indexPath.row].title
        
        return cell
        
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].title
            vc.customTitle = "Picture \(indexPath.row + 1) of \(pictures.count)"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareWithFriends() {
        let av = UIActivityViewController(activityItems: ["Please download my app!"], applicationActivities: nil)
        present(av, animated: true)
    }


}

