//
//  NotificationsTableViewCell.swift
//  ADIN
//
//  Created by Islam on 05.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography
import Reusable
import Tactile
import Permission

class NotificationsTableViewCell: UITableViewCell, Reusable {
    
    // MARK: Properties
    
    fileprivate lazy var titleLabel: UILabel = {
        return  UILabel().then {
            $0.font = .systemFont(ofSize: 15)
        }
    }()
    
    fileprivate lazy var tumblerSwitch: UISwitch = {
        return UISwitch().then {
            $0.onTintColor = .app
        }
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstriants()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        separatorInset = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 0)
        layoutMargins = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 0)
        [titleLabel, tumblerSwitch].forEach {
            contentView.addSubview($0)
        }
    }
    
    fileprivate func configureNotification(permission: Permission, switcher: UISwitch) {
        switcher.setOn(permission.status == .authorized, animated: true)
        switcher.on(.valueChanged) { _ in
            if !switcher.isOn {
                Drop.down("You can enable it through your phone Settings", state: .error)
                switcher.setOn(permission.status == .authorized, animated: true)
            } else {
                permission.request({ status in
                    switcher.setOn(status == .authorized, animated: true)
                    if status != .authorized { Drop.down("You can enable it through your phone Settings", state: .error) }
                })
            }
        }
    }
    
    fileprivate func configureMode() {
        Drop.down("Mode", state: .default)
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(titleLabel, tumblerSwitch) {
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left + 10
            
            $1.centerY == $0.centerY
            $1.right == $1.superview!.right - 10
        }
    }
}

extension NotificationsTableViewCell {
    func setUp(_ sectionTitle: String?, section: Int) {
        titleLabel.text = sectionTitle
        switch section {
        case 0: configureMode()
        case 1: configureNotification(permission: Permission.notifications, switcher: tumblerSwitch)
        default: break
        }
    }
}
