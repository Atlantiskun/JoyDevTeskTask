//
//  CatalogViewModel.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import DataLayer
import Foundation
import RxSwift

final class CatalogViewModel {
    private let disposeBag = DisposeBag()
    private var currentPage: Int = 1
    let authService: AuthService
    let catalogService: CatalogService
    let cats = BehaviorSubject<[Cat]>(value: [])
    let catDetails = PublishSubject<CatDetails>()
    
    init(authService: AuthService, catalogService: CatalogService) {
        self.authService = authService
        self.catalogService = catalogService
        
        nextPage()
        subscribe()
    }
    
    public func signOut() {
        authService.logout()
    }
    
    public func nextPage() {
        catalogService.getCats(from: currentPage)
        currentPage += 1
    }
    
    public func getDetails(for id: String) {
        catalogService.getDetails(for: id)
    }
    
    private func subscribe() {
        catalogService.cats
            .subscribe(onNext: { [weak self] cats in
                guard let self else { return }
                if let oldCats = try? self.cats.value() {
                    self.cats.onNext(oldCats + cats)
                } else {
                    self.cats.onNext(cats)
                }
            })
            .disposed(by: disposeBag)
        
        catalogService.catDetails
            .subscribe(onNext: { [weak self] catDetails in
                guard let self, let catDetails else { return }
                self.catDetails.onNext(catDetails)
            })
            .disposed(by: disposeBag)
        
    }
}
