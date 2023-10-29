//
//  SignInViewController.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

final class SignInViewController: UIViewController {
    var viewModel: SignInViewModel?
    private let disposeBag = DisposeBag()
    
    lazy private var loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Login"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy private var loginError: UITextView = {
        let loginError = UITextView()
        loginError.backgroundColor = .clear
        loginError.isEditable = false
        loginError.translatesAutoresizingMaskIntoConstraints = false
        return loginError
    }()
    
    lazy private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy private var passwordError: UITextView = {
        let loginError = UITextView()
        loginError.backgroundColor = .clear
        loginError.isEditable = false
        loginError.translatesAutoresizingMaskIntoConstraints = false
        return loginError
    }()
    
    lazy private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        configureHierarchy()
        setUpBindings()
    }
}

private extension SignInViewController {
    func configureHierarchy() {
        view.addSubview(loginTextField)
        view.addSubview(loginError)
        view.addSubview(passwordTextField)
        view.addSubview(passwordError)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -AppConstants.Padding.large * 3),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginError.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            loginError.heightAnchor.constraint(equalToConstant: 24),
            loginError.widthAnchor.constraint(equalTo: loginTextField.widthAnchor),
            loginError.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginError.bottomAnchor, constant: AppConstants.Padding.medium),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordError.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordError.heightAnchor.constraint(equalToConstant: 60),
            passwordError.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordError.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -AppConstants.Padding.large * 2),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setUpBindings() {
        guard let viewModel else { return }
        
        Observable.of(loginTextField, passwordTextField)
            .flatMap { $0.rx.controlEvent(.editingDidEndOnExit) }
            .bind { [weak self] _ in self?.viewModel?.signIn() }
            .disposed(by: disposeBag)

        loginTextField.rx.text.orEmpty
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.signIn()
            }
            .disposed(by: disposeBag)
        
        viewModel.errors
            .subscribe(onNext: errorsDisplaying)
            .disposed(by: disposeBag)
    }
    
    func errorsDisplaying(_ errors: [SignInErrors]) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.loginTextField.layer.borderColor = errors.contains(where: { $0.type == .login }) ? UIColor.red.cgColor : UIColor.gray.cgColor
            self?.passwordTextField.layer.borderColor = errors.contains(where: { $0.type == .password }) ? UIColor.red.cgColor : UIColor.gray.cgColor
        }
        
        loginError.attributedText = getAttrString(from: errors, for: .login)
        passwordError.attributedText = getAttrString(from: errors, for: .password)
    }
    
    func getAttrString(from errors: [SignInErrors], for fieldType: SignInErrors.FieldType) -> NSMutableAttributedString {
        let string = errors.filter { $0.type == fieldType } .map { "\($0.errorText) \n" }.reduce("", +)
        let attributedString = NSMutableAttributedString(string: string)
        let style: NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineBreakMode = .byTruncatingTail
        
        
        attributedString.addAttributes(
            [
                NSAttributedString.Key.paragraphStyle: style,
                NSAttributedString.Key.foregroundColor: UIColor.red
            ],
            range: NSMakeRange(0, attributedString.length)
        )
        return attributedString
    }
}
