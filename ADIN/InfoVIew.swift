//
//  InfoVIew.swift
//  ADIN
//
//  Created by Islam Temirbek on 12/6/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class InfoView: UIView {
    
    // MARK: Properties
    
    lazy var numberLabel: UILabel = {
        return UILabel().then {
            $0.text = "123456"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.backgroundColor = UIColor(white: 1, alpha: 0)
            $0.layer.cornerRadius = 5
        }
    }()
    
    lazy var textLabel: UILabel = {
        return UILabel().then {
            $0.text = "Подписчиков"
            $0.backgroundColor = UIColor(white: 1, alpha: 0)
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textAlignment = .center
            $0.numberOfLines = 2
            $0.layer.cornerRadius = 5
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
        [numberLabel, textLabel].forEach {
            addSubview($0)
        }
    }

    // MARK: Setup Constraints

    func setupConstraints() {
        constrain(numberLabel, textLabel) {
            $0.top == $0.superview!.top
            $0.centerX == $0.superview!.centerX
            $0.width == $0.superview!.width
            
            $1.top == $0.bottom + 4
            $1.centerX == $1.superview!.centerX
            $1.width == $1.superview!.width
        }
    }
}
