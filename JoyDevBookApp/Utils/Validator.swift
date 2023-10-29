//
//  Validator.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 28.10.2023.
//

import Foundation

struct Validator {
    static func isPasswordContainsDigit(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[0-9]).{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    static func isPasswordContainsLetter(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-zA-Z]).{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
