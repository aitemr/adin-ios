//
//  AddTableViewFooterView.swift
//  ADIN
//
//  Created by Islam on 07.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class AddTableViewFooterView: UIView {
    
    // MARK: Properties
    
    lazy var button: UIButton = {
        return UIButton(type: .system).then {
            $0.setTitle("Добавить", for: .normal)
            $0.backgroundColor = .app
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)
        }
    }()
    
    // MARK: View LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstriants()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure Views
    
    func configureViews() {
        self.addSubview(button)
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(button) {
            $0.left == $0.superview!.left
            $0.right == $0.superview!.right
            $0.height == 44
            $0.center == $0.superview!.center
        }
    }
    
    // MARK: User Interaction
    
    func buttonDidPress() {
        
    }
    
}
