//
//  DetailPlaceController.swift
//  ADIN
//
//  Created by Islam Temirbek on 12/5/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class DetailPlaceController: UIViewController {
    
    // MARK: Properties
    
    var place: Place?
    
    var cellItems = [
        CellItem(title: "Отзывы", icon: Icon.reviewIcon),
        CellItem(title: "Заказать рекламу", icon: Icon.orderAdvert),
        ]
    
    fileprivate lazy var headerView: DetailPlaceHeaderView = {
        return DetailPlaceHeaderView(frame: CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 280))
    }()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: ProfileTableViewCell.self)
            $0.rowHeight = 50
            $0.tableHeaderView = self.headerView
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstraints()
        loadData()
    }
    
    // MARK: Navigation Bar
    
    func setupNavBar() {
        navigationItem.title = "Информация"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "favoritesIcon"), style: .plain, target: self, action: nil)
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    // MARK: Setup Constraints
    
    func setupConstraints() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    func loadData() {
        guard let place = place else { return }
        if let image = place.proFileImageUrl {
            if let url = URL(string: image)  {
                headerView.avaImageView.kf.setImage(with: url,
                                                    placeholder: #imageLiteral(resourceName: "isa"),
                                                    options: [.transition(.fade(1))],
                                                    progressBlock: nil,
                                                    completionHandler: nil)
            }
        }
        if let followers = place.followers, let averageCommentsCount = place.averageCommentsCount,
            let averageLikesCount = place.averageLikesCount, let averageViewsCount = place.averageViewsCount,
            let username = place.username, let descrip = place.descrip, let involvement = place.involvement,
            let price = place.price, let time = place.time {
            cellItems.insert(CellItem(title: "Цена - \(price) ₽", icon: Icon.walletIcon), at: 0)
            cellItems.insert(CellItem(title: "Время размещения - \(time)", icon: Icon.clockIcon), at: 1)
            headerView.usernameLabel.text = "@" + username
            headerView.statusLabel.text = descrip
            headerView.followersView.numberLabel.text = "\(followers)"
            headerView.involvementView.numberLabel.text = "\(involvement)"
            headerView.instaView.commentsBox.numberLabel.text = "\(averageCommentsCount)"
            headerView.instaView.likesBox.numberLabel.text = "\(averageLikesCount)"
            headerView.instaView.viewsBox.numberLabel.text = "\(averageViewsCount)"
        }
    }
    
    // MARK: User Interaction
    
    func backButtonPressed() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func orderAdvert () { }
    
    func openProfile() {
        guard let place = place else { return }
        guard let username = place.username else { return }
        guard let url = URL(string: "https://www.instagram.com/\(username)/") else { return }
        UIApplication.shared.openURL(url)
    }
}

extension DetailPlaceController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ProfileTableViewCell
        switch (indexPath.section, indexPath.row) {
        case (0, 2), (0, 3), (0, 4): cell.accessoryType = .disclosureIndicator
        default: cell.accessoryType = .none
        }
        let item = cellItems[indexPath.row]
        cell.setUpWithTitle(item.title, sectionIcon: item.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 2):
            self.navigationController?.pushViewController(ReviewViewController(), animated: true)
        case (0, 3): orderAdvert()
        case (0, 4): openProfile()
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
