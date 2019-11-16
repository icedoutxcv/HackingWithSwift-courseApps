//
//  ViewController.swift
//  Project18-Debugging
//
//  Created by Kamil Bloch on 12/11/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Some message", terminator: "")
        assert(1 == 1, "Maths failure!")
        
        for i in 1...100 {
            print("Got number \(i).")
        }

    }


}

