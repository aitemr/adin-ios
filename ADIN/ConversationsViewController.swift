//
//  ConversationsViewController.swift
//  ADIN
//
//  Created by Islam on 05.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Cartography
import Sugar

class ConversationsViewController: UIViewController {
    
    // MARK: Properties
    
    var items = [Conversation]()
    var selectedUser: User?
    
    lazy var tableView: UITableView = {
        return UITableView().then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: ConversationTableViewCell.self)
            $0.rowHeight = 56
        }
    }()

    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstriants()
        fetchData()
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: Setup Constraints
    
    func setupConstriants() {
        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
    
    // MARK: Setup Navigation Bar
    
    func setupNavBar() {
        navigationItem.title = "Чаты"
    }
    
    func fetchData() {
        Conversation.showConversations { (conversations) in
            self.items = conversations
            self.items.sort{ $0.lastMessage.timestamp > $1.lastMessage.timestamp }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.items.count > 0 {
            self.selectedUser = self.items[indexPath.row].user
            let chatVC = ChatViewController()
            chatVC.currentUser = self.items[indexPath.row].user
            self.present(chatVC, animated: true, completion: nil)

//            self.performSegue(withIdentifier: "segue", sender: self)
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(for: indexPath) as ConversationTableViewCell
            
            cell.avatarImageView.image = self.items[indexPath.row].user.profilePic
            cell.usernameLabel.text = self.items[indexPath.row].user.name
            cell.messageLabel.text = self.items[indexPath.row].lastMessage.content as? String
        
            return cell
        }
}


