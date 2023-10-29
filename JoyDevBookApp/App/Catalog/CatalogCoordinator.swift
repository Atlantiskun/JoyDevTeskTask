//
//  CatalogCoordinator.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import DataLayer
import RxSwift

final class CatalogCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let viewModel: CatalogViewModel
    
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = CatalogViewController()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = true
        
        subscribe()
    }
    
    private func subscribe() {
        viewModel.catDetails
            .subscribe(onNext: showDetailsView)
            .disposed(by: disposeBag)
    }
    
    private func showDetailsView(catDetails: CatDetails) {
        let coordinator = SceneDelegate.container.resolve(DetailsCoordinator.self, argument: catDetails)!
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
