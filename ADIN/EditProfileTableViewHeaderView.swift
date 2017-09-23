//
//  EditProfileTableViewHeaderView.swift
//  ADIN
//
//  Created by Islam on 08.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

class EditProfileTableViewHeaderView: UIView {
    
    // MARK: Properties
    
    lazy var avaImageView: UIImageView = {
        return UIImageView().then {
            $0.image = UIImage(named: "isa")
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 35
        }
    }()
    
    lazy var selectImageButton: UIButton = {
        return UIButton(type: .system).then {
            $0.setTitle("Сменить фото профиля", for: .normal)
            $0.setTitleColor(.black, for: .normal)
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
        [avaImageView, selectImageButton].forEach {
            self.addSubview($0)
        }
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(avaImageView, selectImageButton) {
            $0.top == $0.superview!.top + 15
            $0.centerX == $0.superview!.centerX
            $0.height == 70
            $0.width == 70
            
            $1.top == $0.bottom + 15
            $1.centerX == $1.superview!.centerX
            $1.left == $1.superview!.left + 10
            $1.right == $1.superview!.right + 10

        }
    }

}
