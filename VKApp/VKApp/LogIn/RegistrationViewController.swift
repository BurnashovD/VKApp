// RegistrationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс овтечает за экран регистрации пользователя
final class RegistrationViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    // MARK: - Private properties

    private lazy var hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: - IBActions

    @IBAction func saveDataAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard

        guard loginTextField.text != Constants.emptyString,
              passwordTextField.text != Constants.emptyString
        else { changePlaceholderTextAction()
            return
        }
        userDefaults.set(nameTextField.text, forKey: Constants.userDefaultsNameKey)
        userDefaults.set(loginTextField.text, forKey: Constants.userDefaultsLoginKey)
        userDefaults.set(passwordTextField.text, forKey: Constants.userDefaultsPasswordKey)
        dismiss(animated: true)
    }

    // MARK: - Private methods

    private func configUI() {
        view.addGestureRecognizer(hideKeyboardGesture)
        configtextFields()
    }

    private func configtextFields() {
        nameTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.textAlignment = .center
        loginTextField.textAlignment = .center
        passwordTextField.textAlignment = .center
        nameTextField.autocorrectionType = .no
        loginTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
    }

    private func changePlaceholderTextAction() {
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.setNameText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)
            ]
        )
        loginTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.setLoginText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)
            ]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.setPasswordText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)
            ]
        )
    }

    @objc private func hideKeyboardAction() {
        view.endEditing(true)
    }
}

/// Constants
extension RegistrationViewController {
    enum Constants {
        static let userDefaultsNameKey = "name"
        static let userDefaultsLoginKey = "login"
        static let userDefaultsPasswordKey = "password"
        static let emptyString = ""
        static let setNameText = "Укажите имя"
        static let setLoginText = "Укажите логин"
        static let setPasswordText = "Укажите пароль"
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            loginTextField.becomeFirstResponder()
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
