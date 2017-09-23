//
//  DetailPlaceTableViewCell.swift
//  ADIN
//
//  Created by Islam Temirbek on 12/5/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography
import Reusable

struct CellItem {
    var title: String?
    var icon: UIImage?
}

class ProfileTableViewCell: UITableViewCell, Reusable {
    
    // MARK: Properties
    
    lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.font = .systemFont(ofSize: 15)
        }
    }()
    
    fileprivate lazy var sectionImageView: UIImageView = {
        return UIImageView().then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 3
        }
    }()

    // MARK: View LifeCycle

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        sectionImageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    func setUpViews() {
        separatorInset = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 0)
        layoutMargins = UIEdgeInsets(top: 0, left: 54, bottom: 0, right: 0)
        [sectionImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: Setup Constraints
    
    func setUpConstraints() {
        constrain(sectionImageView, titleLabel) {
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left + 10
            $0.height == 25
            $0.width == 25
            
            $1.centerY == $0.centerY
            $1.left == $0.right + 10
        }
    }
}

extension ProfileTableViewCell {
    func setUpWithTitle(_ sectionTitle: String?, sectionIcon: UIImage?) {
        titleLabel.text = sectionTitle
        sectionImageView.image = sectionIcon
    }
}
