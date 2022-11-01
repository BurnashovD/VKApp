// LogInViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за экран входа
final class LogInViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    // MARK: - Private properties

    private lazy var hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        congigUI()
        upAndDownViewAction()
    }

    // MARK: - IBActions

    @IBAction func checkDataAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        guard emailTextField.text == userDefaults.object(forKey: Constants.userDefaultsLoginKey) as? String,
              passwordTextField.text == userDefaults.object(forKey: Constants.userDefaultsPasswordKey) as? String
        else { incorrectPasswordAlertAction()
            return
        }
        performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: self)
    }

    // MARK: - Private methods

    private func congigUI() {
        view.addGestureRecognizer(hideKeyboardGesture)
        configTextFields()
    }

    private func upAndDownViewAction() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil
        ) { _ in
            guard self.view.frame.origin.y >= -80 else { return }
            self.view.frame.origin.y -= 40
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil
        ) { _ in
            self.view.frame.origin.y = 0.0
        }
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

    private func incorrectPasswordAlertAction() {
        let alertController = UIAlertController(
            title: Constants.incorrectPasswordText,
            message: nil,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: Constants.okText, style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }

    @objc private func hideKeyboardAction() {
        view.endEditing(true)
    }
}

/// Constants
extension LogInViewController {
    enum Constants {
        static let incorrectPasswordText = "Неверный логин или пароль"
        static let okText = "Ок"
        static let userDefaultsLoginKey = "login"
        static let userDefaultsPasswordKey = "password"
        static let loginSegueIdentifier = "login"
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
