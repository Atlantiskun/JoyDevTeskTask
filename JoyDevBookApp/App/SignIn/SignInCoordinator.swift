//
//  SignInCoordinator.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import Foundation

final class SignInCoordinator: BaseCoordinator {
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewContoller = SignInViewController()
        viewContoller.viewModel = viewModel
        
        
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [viewContoller]
    }
}
