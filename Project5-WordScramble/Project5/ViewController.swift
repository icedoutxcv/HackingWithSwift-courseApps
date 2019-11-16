//
//  ViewController.swift
//  Project5
//
//  Created by icedoutxcv on 19/03/2019.
//  Copyright © 2019 icedoutxcv. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var allWords = [String]()
    var usedWords = [String]() {
        didSet {
            saveGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usedWords.removeAll()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startNewGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        if !isUdEmpty() {
            resumeGame()
        } else {
            startNewGame()
        }
        
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {[weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer), isOriginal(word: lowerAnswer), isReal(word: lowerAnswer) {
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            return
        }
        
        if !isPossible(word: lowerAnswer) {
            errorTitle = "Word not recognised"
            errorMessage = "You can't just make them up, you know!"
        } else if !isOriginal(word: lowerAnswer) {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        } else {
            guard let tittle = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title!.lowercased())"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
        
        if isGameDone() {
            startNewGame()
        }
    
}

func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }
    
    for letter in word {
        if let position = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: position)
        } else {
            return false
        }
    }
    
    return true
}

func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
}

func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
}


}

extension ViewController {
    
    func isGameDone() -> Bool {
        var statusArray = [Bool]()
        
        usedWords.forEach { word in
            if let status = title?.contains(word) {
                statusArray.append(true)
            } else {
                statusArray.append(false)
            }
        }
        
        if statusArray.contains(false) {
            return true
        }
        
        return false
    }
    
    func isUdEmpty() -> Bool {
        if defaults.string(forKey: "title")?.isEmpty ?? true {
            return true
        }
        return false
    }
    
    func clearUD() {
        var titleFromUD = defaults.string(forKey: "title") as! String ?? ""
        var usedWordsFromUD = defaults.array(forKey: "usedwords") as! [String] ?? [String]()
        
        titleFromUD = ""
        usedWordsFromUD = [String]()
    }
    
    func saveGame() {
        if !usedWords.isEmpty {
            defaults.set(usedWords, forKey: "usedwords")
            defaults.set(title, forKey: "title")
        }
    }
    
    func resumeGame () {
        let titleFromUD = defaults.string(forKey: "title") as! String ?? ""
        let usedWordsFromUD = defaults.array(forKey: "usedwords") as! [String] ?? [String]()
        
        title = titleFromUD
        usedWords = usedWordsFromUD
        tableView.reloadData()
        
        print("usedwordsUD: \(usedWordsFromUD) / titleFromUD: \(titleFromUD)")
    }
    
    @objc func startNewGame(){
        clearUD()
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
}



