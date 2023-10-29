//
//  DetailsViewController.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import UIKit
import RxSwift
import SwiftUI

final class DetailsViewController: UIViewController {
    private enum CellType {
        case name
        case description
        case extra
    }
    private let disposeBag = DisposeBag()
    var viewModel: DetailsViewModel?
    
    lazy private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var controller: UIHostingController<DetailsView> = {
        let view = DetailsView(details: viewModel?.catDetails)
        let controller = UIHostingController(rootView: view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
        
    }()
    lazy var catImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        setUpBindings()
    }
}

extension DetailsViewController {
    func configureHierarchy() {
        view.addSubview(backButton)
        view.addSubview(controller.view)
        controller.rootView.details = viewModel?.catDetails
        
        catImage.sd_setImage(
            with: URL(string: viewModel?.catDetails.imageUrl ?? ""),
            placeholderImage: UIImage(named: "catPlaceholder"),
            context: [.imageThumbnailPixelSize: AppConstants.ImageThumbnailPixelSize.middle]
        )
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: AppConstants.Padding.large * 2),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Padding.medium),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            controller.view.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: AppConstants.Padding.medium),
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -AppConstants.Padding.large),
        ])
    }
    
    func setUpBindings() {
        backButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.didTapBack.onNext(())
            }
            .disposed(by: disposeBag)
    }
}
