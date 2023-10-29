//
//  Container+RegisterDependencies.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 26.10.2023.
//

import Swinject

extension Container {
    public func registerDependencies() {
        registerServices()
        registerCoordinators()
        registerViewModels()
    }
}
