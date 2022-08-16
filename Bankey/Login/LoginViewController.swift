//
//  ViewController.swift
//  Bankey
//
//  Created by Reese on 2022/08/01.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    //func didLogin(_ sender: LoginViewController) // pass data
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subTitleLable = UILabel()
    
    let loginView = LoginView()
    let signInBtn = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    // animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInBtn.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        titleLabel.alpha = 0
        
        subTitleLable.translatesAutoresizingMaskIntoConstraints = false
        subTitleLable.textAlignment = .center
        subTitleLable.font = UIFont.preferredFont(forTextStyle: .title3)
        subTitleLable.adjustsFontForContentSizeCategory = true
        subTitleLable.numberOfLines = 0
        subTitleLable.text = "Your premium source for all things banking!"
        subTitleLable.alpha = 0
        
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        signInBtn.configuration = .filled()
        signInBtn.configuration?.imagePadding = 8 // for indicator sapcing
        signInBtn.setTitle("Sign In", for: [])
        signInBtn.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error Failure"
        errorMessageLabel.isHidden = true
        
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLable)
        view.addSubview(loginView)
        view.addSubview(signInBtn)
        view.addSubview(errorMessageLabel)
        
        // Title
        NSLayoutConstraint.activate([
            subTitleLable.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        // Subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitleLable.bottomAnchor, multiplier: 3),
            subTitleLable.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        subtitleLeadingAnchor = subTitleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // Login Button
        NSLayoutConstraint.activate([
            signInBtn.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInBtn.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInBtn.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // Error Message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInBtn.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc private func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configView(withMessage: "Username / password cannot be blank!")
            return
        }
        
        if username == "lauriel" && password == "hi" {
            signInBtn.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        }
        else {
            configView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]  // 0에서 시작, 오른쪽으로 10, 왼쪽으로 10, 오른쪽으로 10, 0으로 돌아감
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInBtn.layer.add(animation, forKey: "shake")
    }
}

// MARK: - Animations
extension LoginViewController {
    private func animate() {
        let duration = 1.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            //self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.4)
        
        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.subTitleLable.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.2)
    }
}
