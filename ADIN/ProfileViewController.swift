//
//  ProfileViewController.swift
//  ADIN
//
//  Created by Islam Temirbek on 10/10/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography
import Firebase
import MessageUI

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: Properties
    
    fileprivate lazy var cellItems = [
        [CellItem(title: "temirbekia4@gmail.com", icon: Icon.account),
         CellItem(title: "Мои аккануты", icon: Icon.instagramIcon),
         CellItem(title: "Режим исполнителя", icon: nil)],
        [CellItem(title: "Показывать уведомления", icon: nil)],
        [CellItem(title: "Написать нам", icon: Icon.mailIcon),
         CellItem(title: "Наш сайт", icon: Icon.compasIcon),
         CellItem(title: "Порекомендавать другу", icon: Icon.shareIcon),
         CellItem(title: "Поставить рейтинг в App Store", icon: Icon.rateUsIcon)
        ],
        [CellItem(title: "Выйти", icon: Icon.signOut)]
    ]
    
    fileprivate lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .grouped).then {
            $0.register(cellType: ProfileTableViewCell.self)
            $0.register(cellType: NotificationsTableViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            $0.tableHeaderView = UIView()
            $0.tableFooterView = UIView()
            $0.rowHeight = 44
            $0.backgroundColor = .athensGray
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
        setupConstrainsts()
        loadData()
    }
    
    // MARK: Setup Navigation Bar
    
    func setupNavBar() {
        navigationItem.title = "Профиль"
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
    
    // MARK: Load Data
    
    func loadData() {
        guard let email = Auth.auth().currentUser?.email else { return }
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileTableViewCell
        cell?.titleLabel.text = email
        tableView.reloadData()
    }
    
    // MARK: User Interactions
    
    @objc fileprivate func closeButtonPressed(_ sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func feedback() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([Constant.companyMail])
        mailComposerVC.setSubject(Constant.appName)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let actionSheetController: UIAlertController =
            UIAlertController(title: "Could Not Send Email",
                              message: "Your device could not send e-mail.  Please check e-mail configuration and try again.",
                              preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            actionSheetController.dismiss(animated: true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func openWebsite() {
        guard let url = URL(string: "http://adinapp.me") else { return }
        UIApplication.shared.openURL(url)
    }
    
    func share() {
        if let itunesUrl = URL(string: Constant.appUrl) {
            let objectsToShare = [Constant.appName, itunesUrl] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .addToReadingList]
            activityVC.popoverPresentationController?.sourceView = UIView()
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func rate() {
        guard let url = URL(string : Constant.reviewUrl) else { return }
        guard #available(iOS 10, *) else {
            UIApplication.shared.openURL(url)
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func onLogoutPress() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                (UIApplication.shared.delegate as? AppDelegate)?.loadLoginPages()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = cellItems[indexPath.section][indexPath.row]
        switch (indexPath.section, indexPath.row) {
        case (0, 2), (1, 0):
            let cell = tableView.dequeueReusableCell(for: indexPath) as NotificationsTableViewCell
            cell.setUp(item.title, section: indexPath.section)
            cell.accessoryType = .none
            return cell
        case (3, 0):
            let cell = tableView.dequeueReusableCell(for: indexPath) as ProfileTableViewCell
            cell.setUpWithTitle(item.title, sectionIcon: item.icon)
            cell.accessoryType = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ProfileTableViewCell
            cell.setUpWithTitle(item.title, sectionIcon: item.icon)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
        case (0, 1):
            self.navigationController?.pushViewController(MyAccountsViewController(), animated: true)
        case (2, 0): feedback()
        case (2, 1): openWebsite()
        case (2, 2): share()
        case (2, 3): rate()
        case (3, 0): onLogoutPress()
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return "ПРОФИЛЬ"
        case 1:  return "УВЕДОМЛЕНИЯ"
        case 2:  return "ОБРАТНАЯ СВЯЗЬ"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 3:  return 5
        default: return 20
        }
    }
}
