//
//  SignInViewModel.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import DataLayer
import Foundation
import RxSwift

public enum SignInErrors: CaseIterable {
    public enum FieldType {
        case login
        case password
    }
    
    case emptyLogin
    case emptyPassword
    case passwordToShort
    case passwordShouldContainsLetter
    case passwordShouldContainsDigit
    
    public var id: Int {
        switch self {
        case .emptyLogin: return 0
        case .emptyPassword: return 1
        case .passwordToShort: return 2
        case .passwordShouldContainsLetter: return 3
        case .passwordShouldContainsDigit: return 4
        }
    }
    
    public var type: FieldType {
        switch self {
        case .emptyLogin: return .login
        default: return .password
        }
    }
    
    public var errorText: String {
        switch self {
        case .emptyLogin: return "Логин не может быть пустым"
        case .emptyPassword: return "Пароль не может быть пустым"
        case .passwordToShort: return "Пароль должен быть длиннее 6 символов"
        case .passwordShouldContainsLetter: return "Пароль должен содержать минимум 1 букву"
        case .passwordShouldContainsDigit: return "Пароль должен содержать минимум 1 цифру"
        }
    }
}

final class SignInViewModel {
    private let disposeBag = DisposeBag()
    let authService: AuthService
    
    let login = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let errors = BehaviorSubject<[SignInErrors]>(value: [])
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    public func signIn() {
        Observable
            .combineLatest(login, password)
            .take(1)
            .filter(fieldsValidate)
            .map { login, password in
                SecureStorage.Credentials(login: login, password: password)
            }
            .bind(onNext: { [weak self] credentials in
                self?.authService.login(with: credentials)
            })
            .disposed(by: disposeBag)
    }
    
    private func fieldsValidate(_ login: String, _ password: String) -> Bool {
        var errors: Set<SignInErrors> = Set((try? errors.value()) ?? [])
        defer {
            self.errors.onNext(Array(errors).sorted(by: { $0.id < $1.id }))
        }
        
        if login.isEmpty, !errors.contains(.emptyLogin) {
            errors.insert(.emptyLogin)
        } else if !login.isEmpty, errors.contains(.emptyLogin) {
            errors.remove(.emptyLogin)
        }
        
        
        guard !password.isEmpty else {
            errors = errors.filter { $0.type == .login }
            errors.insert(.emptyPassword)
            return errors.isEmpty
        }
        
        if errors.contains(.emptyPassword) {
            errors.remove(.emptyPassword)
        }
        
        guard password.count >= 6 else {
            errors = errors.filter { $0.type == .login }
            errors.insert(.passwordToShort)
            return errors.isEmpty
        }
        
        if errors.contains(.passwordToShort) {
            errors.remove(.passwordToShort)
        }
        
        if !Validator.isPasswordContainsDigit(password), !errors.contains(.passwordShouldContainsDigit) {
            errors.insert(.passwordShouldContainsDigit)
        } else if Validator.isPasswordContainsDigit(password), errors.contains(.passwordShouldContainsDigit) {
            errors.remove(.passwordShouldContainsDigit)
        }
        
        if !Validator.isPasswordContainsLetter(password), !errors.contains(.passwordShouldContainsLetter) {
            errors.insert(.passwordShouldContainsLetter)
        } else if Validator.isPasswordContainsLetter(password), errors.contains(.passwordShouldContainsLetter) {
            errors.remove(.passwordShouldContainsLetter)
        }

        return errors.isEmpty
    }
}
