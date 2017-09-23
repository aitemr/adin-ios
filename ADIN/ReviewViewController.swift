//
//  ReviewViewController.swift
//  ADIN
//
//  Created by Islam on 05.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureViews()
        configureConstriants()
    }
    
    // MARK: Setup Navigation Bar
    
    func setupNavBar() {
        navigationItem.title = "Отзывы"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        view.backgroundColor = .alabaster
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
    }
    
    // MARK: User Interaction
    
    func backButtonPressed() {
        let _ = navigationController?.popViewController(animated: true)
    }
}
