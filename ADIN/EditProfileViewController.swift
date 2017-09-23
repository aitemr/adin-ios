//
//  EditProfileViewController.swift
//  ADIN
//
//  Created by Islam on 08.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class EditProfileViewController: UIViewController {
    
    // MARK: Properties
    
    let cellItems = [[
        CellItem(title: "Islam Temirbek", icon: Icon.userIcon),
        CellItem(title: "example@gmail.com", icon: Icon.mailIcon)
    ]]
    
    lazy var headerView: EditProfileTableViewHeaderView = {
        return EditProfileTableViewHeaderView(frame: CGRect(x: 0, y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 140))
    }()
    
    lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: AddTableViewCell.self)
            $0.rowHeight = 44
            $0.tableHeaderView = self.headerView
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViews()
        configureConstriants()
    }
    
    // MARK: Configure Navigation Bar
    
    func configureNavBar() {
        navigationItem.title = "Изменить профиль"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: nil)
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        view.backgroundColor = .alabaster
        view.addSubview(tableView)
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    // MARK: User Interaction
    
    func backButtonPressed() {
        let _ = navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as AddTableViewCell
        let item = cellItems[indexPath.section][indexPath.row]
        cell.setUp(item.title, sectionIcon: item.icon, section: indexPath.section, sender: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
