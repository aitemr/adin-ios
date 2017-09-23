//
//  InstaInfoView.swift
//  ADIN
//
//  Created by Islam Temirbek on 12/6/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class InstaInfoView: UIView {
    
    // MARK: Properties
    
    lazy var viewsBox: InfoView = {
        return InfoView().then {
            $0.textLabel.text = "Просмотров"
            $0.numberLabel.text = "100K"
        }
    }()
    
    lazy var likesBox: InfoView = {
        return InfoView().then {
            $0.textLabel.text = "Лайков"
            $0.numberLabel.text = "200K"
        }
    }()
    
    lazy var commentsBox: InfoView = {
        return InfoView().then {
            $0.textLabel.text = "Комментариев"
            $0.numberLabel.text = "300K"
        }
    }()
    
    // MARK: View LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        [viewsBox, likesBox, commentsBox].forEach {
            self.addSubview($0)
        }
    }
    
    // MARK: Setup Constraints
    
    func setupConstraints() {
        constrain(viewsBox, likesBox, commentsBox) {
            $0.top == $0.superview!.top + 5
            $0.height == 50
            $0.width == $0.superview!.width / 3
            $0.left == $0.superview!.left
            
            $1.top == $1.superview!.top + 5
            $1.height == 50
            $1.width == $1.superview!.width / 3
            $1.center == $1.superview!.center
            
            $2.top == $2.superview!.top + 5
            $2.height == 50
            $2.width == $2.superview!.width / 3
            $2.right == $2.superview!.right
        }
    }
}
