//
//  Container+Coordinators.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 26.10.2023.
//

import DataLayer
import Swinject
import SwinjectAutoregistration

extension Container {
    internal func registerCoordinators() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(SignInCoordinator.self, initializer: SignInCoordinator.init)
        autoregister(CatalogCoordinator.self, initializer: CatalogCoordinator.init)
        register(DetailsCoordinator.self) { (r, catDetails: CatDetails) in
            DetailsCoordinator(viewModel: r.resolve(DetailsViewModel.self, argument: catDetails)!)
        }
    }
}
