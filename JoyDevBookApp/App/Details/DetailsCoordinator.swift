//
//  DetailsCoordinator.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import DataLayer
import Foundation
import RxSwift

final class DetailsCoordinator: BaseCoordinator {
    private let disposeBag = DisposeBag()
    private let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func start() {
        let viewController = DetailsViewController()
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = true
        
        subscribe()
    }
    
    private func subscribe() {
        viewModel.didTapBack
            .subscribe(onNext: didTapBack)
            .disposed(by: disposeBag)
    }
    
    private func didTapBack() {
        navigationController.isNavigationBarHidden = true
        navigationController.popViewController(animated: true)
        didFinish(coordinator: self)
    }
}
