//
//  AddTableViewCell.swift
//  ADIN
//
//  Created by Islam on 07.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography
import Reusable

class AddTableViewCell: UITableViewCell, Reusable {
    
    // MARK: Properties
    
    fileprivate lazy var sectionImageView: UIImageView = {
        return UIImageView().then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 3
        }
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 0
        return pickerView
    }()
    
    lazy var textField: UITextField = {
        return UITextField().then {
            $0.placeholder = "placeholder"
        }
    }()
    
    // MARK: View LifeCycle
    
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
        [sectionImageView, textField].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: Configure Constraints
    
    func configureConstriants() {
        constrain(sectionImageView, textField) {
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left + 10
            $0.height == 25
            $0.width == 25
            
            $1.left == $0.right + 10
            $1.right == $1.superview!.right - 10
            $1.height == $1.superview!.height
        }
    }
}

extension AddTableViewCell {
    func setUp(_ sectionPlaceHolder: String?, sectionIcon: UIImage?, section: Int, sender: Any) {
        switch section {
        case 1, 3:
            pickerView.tag = section
            textField.inputView = pickerView
            pickerView.dataSource = sender as? UIPickerViewDataSource
            pickerView.delegate = sender as? UIPickerViewDelegate
        case 4:
            textField.keyboardType = .numberPad
        default: break
        }
        textField.placeholder = sectionPlaceHolder
        textField.adjustsFontSizeToFitWidth = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        sectionImageView.image = sectionIcon
    }
}
