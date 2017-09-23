//
//  WelcomeViewController.swift
//  ADIN
//
//  Created by Islam Temirbek on 10/4/16.
//  Copyright © 2016 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography
import Firebase

class WelcomeViewController: UIViewController {
    
    // MARK: Properties
    
    fileprivate lazy var bottomView: UIView = {
        return UIView().then {
            $0.backgroundColor = .white
        }
    }()
    
    fileprivate lazy var appName: UILabel = {
        return UILabel().then {
            $0.text = "ADIN"
            $0.textAlignment = .center
            $0.font  = .systemFont(ofSize: 50)
            $0.textColor = .white
        }
    }()
    
    fileprivate lazy var appImageView: UIImageView = {
        return UIImageView().then {
            $0.image = UIImage(named: "logo")
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 15
            $0.layer.masksToBounds = true
        }
    }()
    
    fileprivate lazy var appDescription: UILabel = {
        return UILabel().then {
            $0.text = "БИРЖА РЕКЛАМЫ В INSTAGRAM \n ADVERTISING INSTAGRAM"
            $0.textAlignment = .center
            $0.font  = .systemFont(ofSize: 16)
            $0.textColor = UIColor.black.withAlphaComponent(0.5)
            $0.numberOfLines = 0
        }
    }()
    
    fileprivate lazy var signInButton: UIButton = {
        return UIButton(type: .system).then {
            $0.setTitle("ВОЙТИ", for: .normal)
            $0.backgroundColor = .app
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(signInDidPress(_:)), for: .touchUpInside)
        }
    }()
    
    fileprivate lazy var signUpButton: UIButton = {
        return UIButton(type: .system).then {
            $0.setTitle("РЕГИСТРАЦИЯ", for: .normal)
            $0.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 2
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(signUpDidPress(_:)), for: .touchUpInside)
        }
    }()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setUpViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Setup NavigationBar
    
    fileprivate func setupNavBar() { }
    
    // MARK: Setup Views
    
    func setUpViews(){
        setUpGradient()
        [appDescription, signInButton, signUpButton, appImageView].forEach {
            bottomView.addSubview($0)
        }
        [bottomView, appName].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: Setup Gradient
    
    func setUpGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [#colorLiteral(red: 0.9607843137, green: 0.3058823529, blue: 0.6352941176, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.462745098, blue: 0.462745098, alpha: 1).cgColor]
        view.layer.addSublayer(gradient)
    }
    
    // MARK: Setup Constraints
    
    func setUpConstraints() {
        constrain(bottomView, signInButton, signUpButton, appDescription, appImageView) {
            $0.bottom == $0.superview!.bottom
            $0.width == $0.superview!.width
            $0.height == 240
            
            $1.height == 45
            $1.bottom == $1.superview!.bottom - 38
            $1.left == $1.superview!.left + 25
            $1.right == $1.superview!.centerX - 5
            
            $2.height == $1.height
            $2.bottom == $1.bottom
            $2.right == $2.superview!.right - 25
            $2.left == $2.superview!.centerX + 5
            
            $3.bottom == $2.top - 30
            $3.centerX == $3.superview!.centerX
            $3.width == $3.superview!.width - 30
            
            $4.bottom == $3.top - 40
            $4.centerX == $4.superview!.centerX
            $4.width == 102
            $4.height == 103
        }
        
        constrain(appName, appImageView){
            $0.centerX == $0.superview!.centerX
            $0.bottom == $1.top - 90
        }
    }
    
    // MARK: User Interaction
    
    @objc fileprivate func signInDidPress(_ sender: UIButton) {
        let vc = SignInViewController()
        vc.type = "signIn"
        let _ = navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func signUpDidPress(_ sender: UIButton) {
        let vc = SignInViewController()
        vc.type = "signUp"
        let _ = navigationController?.pushViewController(vc, animated: true)
    }

}
