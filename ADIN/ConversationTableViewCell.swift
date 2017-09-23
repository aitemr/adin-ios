//
//  ConversationTableViewCell.swift
//  ADIN
//
//  Created by Aidar Nugmanov on 7/14/17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

//
//  PlaceTableViewCell.swift
//  ADIN
//
//  Created by Islam Temirbek on 12/2/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Cartography
import Sugar
import Reusable

class ConversationTableViewCell: UITableViewCell, Reusable {
    
    // MARK: Properties
    
    lazy var avatarImageView: UIImageView = {
        return UIImageView().then {
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.image = UIImage(named: "isa")
        }
    }()
    
    lazy var usernameLabel: UILabel = {
        return UILabel().then {
            $0.textAlignment = .left
            $0.textColor = .black
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 14, weight: UIFontWeightRegular)
            $0.text = "@itemir"
        }
    }()
    
    lazy var messageLabel: UILabel = {
        return UILabel().then {
            $0.textAlignment = .left
            $0.textColor = UIColor.black.withAlphaComponent(0.5)
            $0.font = .systemFont(ofSize: 13)
            $0.text = "Видео"
        }
    }()

    
    // MARK: View LifeCycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setUpViews(){
        [avatarImageView, usernameLabel,
         messageLabel].forEach{
            contentView.addSubview($0)
        }
    }
    
    // MARK: Setup Constraints
    
    func setUpConstraints(){
        constrain(avatarImageView, usernameLabel, messageLabel){
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left + 15
            $0.height == 40
            $0.width == 40
            
            $1.top == $1.superview!.top + 10
            $1.left == $0.right + 15
            
            $2.top == $1.bottom + 5
            $2.left == $1.left
            
        }
    }
    
}
