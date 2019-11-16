//
//  ViewController.swift
//  Guess the flag
//
//  Created by icedoutxcv on 13/03/2019.
//  Copyright © 2019 icedoutxcv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
        
    @IBOutlet var scoreInBar: UIBarButtonItem!
    
    var buttons: [UIButton?] = [] {
        didSet{
            buttons += [button1, button2, button3]
        }
    }
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var numberOfQuestionAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateScoreInBar()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        for button in buttons {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
        }
        askQuestion(action: nil)
    }

    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        
    }
    
    func updateScoreInBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: self, action: #selector(showScore))
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong Thats the flag of \(countries[sender.tag])"
            score -= 1
        }
        numberOfQuestionAsked += 1
        updateScoreInBar()
        
        if numberOfQuestionAsked == 10 {
            let ac = UIAlertController(title: "Score number", message: "Your score is \(score), questions asked: \(numberOfQuestionAsked) ", preferredStyle: .alert)
            present(ac, animated: true)
            score = 0
            numberOfQuestionAsked = 0
        }
        
        let ac = UIAlertController(title: title, message: "Continue", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
           }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Score", message: "Your score is: \(score)", preferredStyle: .alert)
        present(ac, animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
}


