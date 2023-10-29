//
//  AppCoordinator.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 26.10.2023.
//

import DataLayer
import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    var window: UIWindow?
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    override func start() {
        guard let window else { fatalError("Window is nill.") }
        window.makeKeyAndVisible()
        
        authService.isUserExist()
            ? showCatalog()
            : showSignIn()
        
        subscribeToUserStatus()
    }
    
    private func subscribeToUserStatus() {
        authService.didSignIn
            .subscribe(onNext: { [weak self] in
                self?.showCatalog(withPushAnimation: true)
            })
            .disposed(by: disposeBag)

        authService.didSignOut
            .subscribe(onNext: { [weak self] in
                self?.showSignIn()
            })
            .disposed(by: disposeBag)
    }
    
    private func showSignIn() {
        if let _ = childCoordinators.first as? SignInCoordinator {
            navigationController.popToRootViewController(animated: true)
        } else {
            removeChildCoordinators()
            
            let coordinator = SceneDelegate.container.resolve(SignInCoordinator.self)!
            coordinator.navigationController = navigationController
            
            ViewControllerUtils.setRootViewController(
                window: window,
                viewController: coordinator.navigationController,
                withAnimation: true
            )
            
            start(coordinator: coordinator)
        }
    }
    
    private func showCatalog(withPushAnimation: Bool = false) {
        let coordinator = SceneDelegate.container.resolve(CatalogCoordinator.self)!
        coordinator.navigationController = withPushAnimation ? navigationController : BaseNavigationController()
        
        if let signInCoordinator = childCoordinators.first as? SignInCoordinator {
            signInCoordinator.start(coordinator: coordinator)
        } else {
            start(coordinator: coordinator)
        }
        
        if !withPushAnimation {
            ViewControllerUtils.setRootViewController(
                window: window,
                viewController: coordinator.navigationController,
                withAnimation: true
            )
        }
    }
}
