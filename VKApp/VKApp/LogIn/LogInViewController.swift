// LogInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа
final class LogInViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var loginScrollView: UIScrollView!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var logInButton: UIButton!
    @IBOutlet private var loadingView: UIView!

    // MARK: - Private properties

    private lazy var hideKeyboardGesture = UITapGestureRecognizer()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        congigUI()
    }

    // MARK: - Public methods

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }

    // MARK: - IBActions

    @IBAction private func checkDataAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        guard emailTextField.text == userDefaults.object(forKey: Constants.userDefaultsLoginKey) as? String,
              passwordTextField.text == userDefaults.object(forKey: Constants.userDefaultsPasswordKey) as? String
        else {
            callAlertAction(
                controllerTitle: Constants.incorrectPasswordText,
                actionTitle: Constants.okText,
                textField: false
            )
            return
        }
        loadingView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let loadingViewTag = self.view.viewWithTag(2) else { return }
            loadingViewTag.removeFromSuperview()
            self.performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: self)
        }
    }

    // MARK: - Private methods

    private func congigUI() {
        view.addGestureRecognizer(hideKeyboardGesture)
        loginScrollView.showsVerticalScrollIndicator = false
        hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        configTextFields()
        loadingView.isHidden = true
        loadingView.tag = 2
        emailTextField.addTarget(self, action: #selector(openVKWebViewAction), for: .touchDown)
    }

    private func addNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowAction),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func configTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 15
        emailTextField.autocorrectionType = .no
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.autocorrectionType = .no
    }

    @objc private func keyboardWillShowAction(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue
              .size else { return }
        let contentInsent = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        loginScrollView.contentInset = contentInsent
        loginScrollView.scrollIndicatorInsets = contentInsent
        let buttonRect = CGRect(
            x: logInButton.frame.midX,
            y: logInButton.frame.midY,
            width: logInButton.frame.width,
            height: logInButton.frame.height
        )
        loginScrollView.scrollRectToVisible(buttonRect, animated: true)
    }

    @objc private func keyboardWillHideAction() {
        let contentInsent = UIEdgeInsets.zero
        loginScrollView.contentInset = contentInsent
    }

    @objc private func hideKeyboardAction() {
        view.endEditing(true)
    }

    @objc private func openVKWebViewAction() {
        emailTextField.text = Constants.emailAndPasswordText
        passwordTextField.text = Constants.emailAndPasswordText
        performSegue(withIdentifier: Constants.vkWebSegueIdentifier, sender: self)
    }
}

/// Constants
extension LogInViewController {
    private enum Constants {
        static let incorrectPasswordText = "Неверный логин или пароль"
        static let okText = "Ок"
        static let userDefaultsLoginKey = "login"
        static let userDefaultsPasswordKey = "password"
        static let loginSegueIdentifier = "login"
        static let vkWebSegueIdentifier = "vkWeb"
        static let emailAndPasswordText = "1"
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
