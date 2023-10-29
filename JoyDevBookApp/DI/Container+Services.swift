//
//  Container+Services.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 26.10.2023.
//

import Swinject
import SwinjectAutoregistration
import DataLayer

extension Container {
    internal func registerServices() {
        autoregister(AuthService.self, initializer: AuthService.init)
            .inObjectScope(.container)
        autoregister(CatalogService.self, initializer: CatalogService.init)
    }
}
