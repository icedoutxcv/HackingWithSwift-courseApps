//
//  SubmitViewController.swift
//  Project33-WhatsThatWhistle
//
//  Created by icedoutxcv on 30/07/2020.
//

import UIKit

class SubmitViewController: UIViewController {
    
    var genre: String!
    var comments: String!
    
    var stackView: UIStackView!
    var status: UILabel!
    var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .gray
        
        stackView = UIStackView()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Submitting.."
        status.textColor = .white
        status.font = .preferredFont(forTextStyle: .title1)
        status.numberOfLines = 0
        status.textAlignment = .center
        
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()

        
        stackView.addSubview(status)
        stackView.addSubview(spinner)
        
    }
    
}
