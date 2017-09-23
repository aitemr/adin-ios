//
//  HomeViewController.swift
//  ADIN
//
//  Created by Islam Temirbek on 10/10/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class PlaceViewController: UIViewController {
    
    // MARK: Properites
    
    var places: [Place] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        return UITableView().then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: PlaceTableViewCell.self)
            $0.rowHeight = 56
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupNavBar()
        setupViews()
        setupConstrainsts()
    }
    
    // MARK: Load Data
    
    func loadData() {
        Place.fetch { (places, error) in
            guard let places = places else { return }
            if error == nil {
                self.places = places
            }
        }
    }
    
    // MARK: Setup Navigation Bar
    
    func setupNavBar() {
        navigationItem.title = "Площадки"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favoritesIcon"), style: .plain, target: self, action: #selector(favoritesButtonDidPress))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIcon"), style: .plain, target: self, action: #selector(filterButtonDidPress))
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: Setup Constraints
    
    func setupConstrainsts() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    func filterButtonDidPress() {
    }
    
    func favoritesButtonDidPress() {
        self.navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }

}

extension PlaceViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let _ = navigationController?.pushViewController(DetailPlaceController().then {
            $0.place = places[indexPath.row]
        }, animated: true)
    }
}
