//
//  SignInViewController.swift
//  ADIN
//
//  Created by Islam on 15.02.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

import UIKit
import Sugar
import Cartography
import Firebase
import SVProgressHUD

class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    var type: String?
    
    lazy var textField: (_ placeholder: String, _ flag: Bool) -> PaddingTextField = {
        placeholder, flag in
        return PaddingTextField(verticalPadding: 8, horizontalPadding: 10).then {
            $0.layer.cornerRadius = 2
            $0.backgroundColor = .white
            $0.keyboardType = (!flag ? .emailAddress : .default)
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            let attributes = [
                NSForegroundColorAttributeName: UIColor(white: 0, alpha: 0.6),
                NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
            ]
            $0.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            $0.isSecureTextEntry = flag
            $0.adjustsFontSizeToFitWidth = true
        }
    }
    
    fileprivate lazy var emailTextField: PaddingTextField = {
        return self.textField("Почта", false)
    }()
    
    fileprivate lazy var passwordTextField: PaddingTextField = {
        return self.textField("Пароль", true)
    }()
    
    fileprivate lazy var signInButton: UIButton = {
        return UIButton(type: .system).then {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 2
            $0.backgroundColor = .app
            $0.setTitleColor(.white, for: .normal)
            $0.setTitle("Войти через почту", for: .normal)
            $0.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
        }
    }()
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: Setup Navigation Bar
    
    fileprivate func setupNavBar() {
        guard let type = self.type else { return }
        title = type.contains("signIn") ? "Войти через почту" : "Регистрация"
        signInButton.setTitle(title, for: .normal)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 17)!,  NSForegroundColorAttributeName: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.hidesBackButton = true
    }
    
    // MARK: Setup Views
    
    fileprivate func setUpViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain,
                                                           target: self, action: #selector(popViewController))
        view.backgroundColor = .athensGray
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        [emailTextField, passwordTextField, signInButton].forEach { view.addSubview($0) }
    }
    
    // MARK: Setup Constraints
    
    fileprivate func setUpConstraints() {
        constrain(emailTextField, passwordTextField, signInButton, view) {
            $0.top == $3.top + 20
            $0.leading == $3.leading + 20
            $0.trailing == $3.trailing - 20
            $0.height == 50
            
            $1.top == $0.bottom + 15
            $1.leading == $0.leading
            $1.trailing == $0.trailing
            $1.height == $0.height
            
            $2.top == $1.bottom + 15
            $2.leading == $1.leading
            $2.trailing == $1.trailing
            $2.height == $1.height
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: User Interaction
    
    @objc fileprivate func signIn(_ sender: UIButton) {
        dispatch {
            self.hideKeyboard()
            SVProgressHUD.show(withStatus: "Загурзка...")
            SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            guard let email = self.emailTextField.text,
                let password = self.passwordTextField.text,
                !email.isEmpty && !password.isEmpty else {
                    SVProgressHUD.dismiss()
                    Drop.down("Ошибка", state: .error)
                    return }
            guard let type = self.type else { return }
            type.contains("signIn") ? self.signInWithEmail(email: email, password: password)
                : self.signUpWithEmail(email: email, password: password)
        }
        
    }
    
    @objc fileprivate func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                Drop.down("Ошибка", state: .error)
                self.refreshData()
            } else {
                (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @objc fileprivate func signUpWithEmail(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                guard let error = error else { return }
                Drop.down(error.localizedDescription, state: .error)
                self.refreshData()
            } else {
                (UIApplication.shared.delegate as? AppDelegate)?.loadMainPages()
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    @objc fileprivate func popViewController() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
    
    func refreshData() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
