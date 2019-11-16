//
//  ViewController.swift
//  Whitehouse-7
//
//  Created by Kamil Bloch on 31/03/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(matchPetitions))
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            
        } else {
           urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // OK
                parse(json: data)
                return
            }
            showError()
            
        }
        
    }
    
    @objc func showCredits(){
        let ac = UIAlertController(title: "Our message!", message: "That data comes from wethepeopleAPI of the WhiteHouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func matchPetitions() {
        let ac = UIAlertController(title: "Searching", message: "Type the string and see what we have!", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] action in
            
            guard let userInput = ac?.textFields?[0].text else { return }
            self?.searchForText(withText: userInput)
        }
        
       
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func searchForText(withText text: String) {
        if !filteredPetitions.isEmpty {
            filteredPetitions.removeAll()
        }
        
        for petition in petitions {
            if petition.title.contains(text) || petition.body.contains(text) {
                filteredPetitions.append(petition)
                print(filteredPetitions)
            }
        }
        var tempPetitions = petitions
        petitions = filteredPetitions
        tableView.reloadData()
        petitions = tempPetitions

    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: DetailViewController = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPartitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPartitions.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error..", message: "There was an problem loading the feed, please check your connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    
}

