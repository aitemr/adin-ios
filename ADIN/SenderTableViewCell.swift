//
//  SenderTableViewCell.swift
//  ADIN
//
//  Created by Aidar Nugmanov on 7/14/17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Cartography
import Sugar
import Reusable

class SenderTableViewCell: UITableViewCell, Reusable {

    
    lazy var message: UITextView = {
        let message = UITextView()
        message.textAlignment = .left
        message.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        return message
    }()
    
    lazy var messageBackground: UIImageView = {
        let messageBackground = UIImageView()
        messageBackground.clipsToBounds = true
        messageBackground.layer.cornerRadius = 15
        return messageBackground
    }()
    
    lazy var profilePic: RoundedImageView = {
        let profilePic = RoundedImageView()
        return profilePic
    }()
    
    // MARK: View LifeCycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setUpViews(){
        
        [message, messageBackground, profilePic].forEach{
            contentView.addSubview($0)
        }
    }
    
    
    // MARK: Setup Constraints
    
    func setUpConstraints() {
        constrain(message, messageBackground, contentView) { msg, mb, cv in
            msg.top == cv.top + 6
            msg.bottom == cv.bottom - 6
            msg.left == cv.left + 10
            
            msg.center == mb.center
            
        }
    }
    
    
    func clearCellData()  {
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
    }
    
}
