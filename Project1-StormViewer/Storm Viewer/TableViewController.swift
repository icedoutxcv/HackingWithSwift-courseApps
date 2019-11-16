//
//  ViewController.swift
//  Storm Viewer
//
//  Created by icedoutxcv on 10/03/2019.
//  Copyright © 2019 icedoutxcv. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var pictures = [String]()
    
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
                pictures.append(item)
            }
            
        }
        pictures = pictures.sorted { $0 < $1 }
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pictures", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.customTitle = "Picture \(indexPath.row + 1) of \(pictures.count)"
            
            navigationController?.pushViewController(vc, animated: true)
        }
        addRecord(with: pictures[indexPath.row])
    }
    
    @objc func shareWithFriends() {
        let av = UIActivityViewController(activityItems: ["Please download my app!"], applicationActivities: nil)
        present(av, animated: true)
    }
    
    func addRecord(with imageNamed: String) {
        let defaults = UserDefaults.standard
        var number = defaults.integer(forKey: imageNamed)
        var counter = 0
        
        if number == 0 {
            counter += 1
            defaults.set(counter, forKey: imageNamed)
            print("Image \(imageNamed) was shown: \(defaults.integer(forKey: imageNamed)) times")
            counter = 0
        } else {
            number += 1
            defaults.set(number, forKey: imageNamed)
            print("Image \(imageNamed) was shown: \(defaults.integer(forKey: imageNamed)) times")
        }
    }


}

