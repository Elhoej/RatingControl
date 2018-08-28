//
//  ViewController.swift
//  RatingControl
//
//  Created by Simon Elhoej Steinmejer on 28/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let rating = RatingControl(frame: .zero)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.addTarget(self, action: #selector(updateRating(sender:)), for: .valueChanged)
        view.addSubview(rating)
        rating.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rating.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rating.widthAnchor.constraint(equalToConstant: 300).isActive = true
        rating.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

    @objc func updateRating(sender: RatingControl)
    {
        let starString = sender.value == 1 ? "star" : "stars"
        title = "User rating: \(sender.value) \(starString)"
    }



}

