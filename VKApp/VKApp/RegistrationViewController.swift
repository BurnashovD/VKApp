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
    
    private lazy var hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: - IBActions
    
    @IBAction func saveDataAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard

        userDefaults.set(nameTextField.text, forKey: "name")
        userDefaults.set(loginTextField.text, forKey: "login")
        userDefaults.set(passwordTextField.text, forKey: "password")
        dismiss(animated: true)
    }

    // MARK: - Private methods
    private func configUI() {
        view.addGestureRecognizer(hideKeyboardGesture)
        nameTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
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
