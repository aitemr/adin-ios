//
//  SectionHeaderView.swift
//  ADIN
//
//  Created by Islam Temirbek on 10/16/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography

final class SectionHeaderView: UIView {
    
    // MARK: Properties
    
    fileprivate lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 12, weight: UIFontWeightMedium)
        }
    }()
    
    convenience init(title: String?) {
        self.init()
        titleLabel.text = title
    }
    
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
    
    fileprivate func setupViews() {
        addSubview(titleLabel)
    }
    
    fileprivate func setupConstraints() {
        constrain(titleLabel, self) {
            $0.leading == $1.leading + 8
            $0.bottom == $1.bottom - 8
        }
    }
}
