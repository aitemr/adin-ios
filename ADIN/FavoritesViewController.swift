//
//  FavoritesViewController.swift
//  ADIN
//
//  Created by Islam on 08.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViews()
        configureConstriants()
    }
    
    // MARK: Configure Navigation Bar
    
    func configureNavBar() {
        navigationItem.title = "Избранные"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.hidesBackButton = true
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
