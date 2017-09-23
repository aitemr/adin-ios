//
//  DetailPlaceHeaderView.swift
//  ADIN
//
//  Created by Islam Temirbek on 12/6/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class DetailPlaceHeaderView: UIView {
    
    // MARK: Properties
    
    lazy var profileBackroundView: UIView = {
        return UIView().then {
            $0.backgroundColor = .white
        }
    }()
    
    lazy var avaImageView: UIImageView = {
       return UIImageView().then {
            $0.image = UIImage(named: "isa")
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 40
        }
    }()
    
    lazy var usernameLabel: UILabel = {
        return UILabel().then {
            $0.text = "@aitemr"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
            $0.textAlignment = .center
        }
    }()
    
    lazy var instaHeaderViewTitle: UILabel = {
        return UILabel().then {
            $0.text = "СРЕДНЕЕ КОЛИЧЕСТВО"
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = .center
        }
    }()
    
    lazy var statusLabel: UILabel = {
        return UILabel().then {
            $0.text = "В 2016 году являюсь бренд амбассадором багажа Samsonite"
            $0.backgroundColor = UIColor(white: 1, alpha: 0)
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.layer.cornerRadius = 5
        }
    }()
    
    lazy var followersView: InfoView = {
        return InfoView().then {
            $0.backgroundColor = .clear
        }
    }()
    
    lazy var involvementView: InfoView = {
        return InfoView().then {
            $0.backgroundColor = .clear
        }
    }()
    
    lazy var instaView: InstaInfoView = {
        return InstaInfoView().then {
            $0.backgroundColor = .clear
        }
    }()
    
    lazy var instaHeaderView: UIView = {
        return UIView().then {
            $0.backgroundColor = .app
        }
    }()
    
    func setupTopView() {
        followersView.numberLabel.text = "100K"
        followersView.textLabel.text = "Подписчиков"
        involvementView.numberLabel.text = "0.99%"
        involvementView.textLabel.text = "Вовлеченость"
    }
    
    // MARK: View LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupTopView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        [profileBackroundView, followersView,
         avaImageView, involvementView, usernameLabel,
         statusLabel, instaHeaderView, instaView].forEach {
            addSubview($0)
        }
        instaHeaderView.addSubview(instaHeaderViewTitle)
    }
    
    // MARK: Setup Constraints
    
    func setupConstraints() {
        
        constrain(profileBackroundView, self) {
            profileBackroundImageView, view in
            profileBackroundImageView.edges == view.edges
        }
        
        constrain(avaImageView, usernameLabel, statusLabel, instaHeaderView, instaView) {
            avatarImageView, usernameLabel, statusLabel, instaHeaderView, instaView in
            
            let view =  usernameLabel.superview!
            avatarImageView.top == view.top + 17
            avatarImageView.centerX == view.centerX
            avatarImageView.width == 80
            avatarImageView.height == 80
            
            usernameLabel.top == avatarImageView.bottom + 8
            usernameLabel.leading == view.leading + 20
            usernameLabel.trailing == view.trailing - 20
            usernameLabel.height == 30
            
            statusLabel.top == usernameLabel.bottom + 2
            statusLabel.leading == usernameLabel.leading
            statusLabel.trailing == usernameLabel.trailing
            statusLabel.height == 30
            
            instaHeaderView.top == statusLabel.bottom + 10
            instaHeaderView.width == view.width
            instaHeaderView.left == view.left
            instaHeaderView.right == view.right
            instaHeaderView.height == 35
            
            instaView.top == instaHeaderView.bottom + 10
            instaView.width == view.width
            instaView.left == view.left
            instaView.right == view.right
            instaView.height == 50
        
        }
        
        constrain(self, followersView, avaImageView, involvementView) {
            view, followersView, avaImageView, involvementView in
            followersView.top == view.top + 45
            followersView.left == view.left + 20
            followersView.height == 50
            
            involvementView.top == followersView.top
            involvementView.height == followersView.height
            involvementView.right == view.right - 20
        }
        
        constrain(instaHeaderViewTitle, instaHeaderView) {
            instaHeaderViewTitle, instaHeaderView in
            instaHeaderViewTitle.center == instaHeaderView.center
        }
        
    }
}
