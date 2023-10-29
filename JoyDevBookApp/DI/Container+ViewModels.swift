//
//  Container+ViewModels.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 26.10.2023.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    internal func registerViewModels() {
        autoregister(SignInViewModel.self, initializer: SignInViewModel.init)
        autoregister(CatalogViewModel.self, initializer: CatalogViewModel.init)
        register(DetailsViewModel.self) { _, catDetails in
            DetailsViewModel(catDetails: catDetails)
        }
    }
}
