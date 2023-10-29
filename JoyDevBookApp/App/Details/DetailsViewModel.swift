//
//  DetailsViewModel.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import DataLayer
import Foundation
import RxSwift

final class DetailsViewModel {
    private let disposeBag = DisposeBag()
    let catDetails: CatDetails
    
    let didTapBack = PublishSubject<Void>()
    
    init(catDetails: CatDetails) {
        self.catDetails = catDetails
    }
}
