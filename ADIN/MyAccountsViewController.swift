//
//  MyAccountsViewController.swift
//  ADIN
//
//  Created by Islam on 07.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class MyAccountsViewController: UIViewController {
    
    // MARK: Properties
    
    var places: [Place] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        return UITableView().then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: PlaceTableViewCell.self)
            $0.rowHeight = 56
            $0.showsVerticalScrollIndicator = false
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViews()
        configureConstriants()
        loadData()
    }
    
    // MARK: Configure Navigation Bar
    
    func configureNavBar() {
        navigationItem.title = "Мои аккаунты"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .trash, target: self,
                                                              action: #selector(removeButtonDidPress)),
                                              UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                              action: #selector(addButtonDidPress))]
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        view.addSubview(tableView)
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    // MARK: Load Places
    
    func loadData() {
        Place.fetchCurrentUserPlaces { (places, error) in
            if error == nil {
                guard let places = places else { return }
                self.places = places
            }
        }
    }
    
    // MARK: User Interaction
    
    func backButtonPressed() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func addButtonDidPress() {
        self.navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    func removeButtonDidPress() {
        
    }
    
}

extension MyAccountsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as PlaceTableViewCell
        let place = places[indexPath.row]
        cell.usernameLabel.text =  "@" + place.username!
        cell.themeLabel.text = place.theme
        cell.priceLabel.text = "\(place.price!) ₽"
        if let image = place.proFileImageUrl {
            if let url = URL(string: image)  {
                cell.avatarImageView.kf.setImage(with: url,
                                                 placeholder: #imageLiteral(resourceName: "isa"),
                                                 options: [.transition(.fade(1))],
                                                 progressBlock: nil,
                                                 completionHandler: nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let _ = navigationController?.pushViewController(EditPlaceViewController().then {
            $0.place = places[indexPath.row]
        }, animated: true)
        
    }
    
}
