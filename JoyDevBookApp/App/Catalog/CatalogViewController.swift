//
//  CatalogViewController.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import DataLayer
import UIKit
import RxSwift

final class CatalogViewController: UIViewController {
    enum Section {
        case `default`
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cat>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cat>
    
    var viewModel: CatalogViewModel?
    private let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView! = nil
    private lazy var dataSource = makeDataSource()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureHierarchy()
        setUpBindings()
    }
}

extension CatalogViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .createListLayout(footer: true))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self

        view.addSubview(loginButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: AppConstants.Padding.large * 2),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: AppConstants.Padding.medium),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setUpBindings() {
        guard let viewModel else { return }
        
        loginButton.rx.tap
            .bind { [weak self] in
                self?.viewModel?.signOut()
            }
            .disposed(by: disposeBag)
        
        viewModel.cats
            .subscribe(onNext: { [weak self] cats in
                self?.reload(cats)
            })
            .disposed(by: disposeBag)
    }
}

extension CatalogViewController {
    private func makeDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration<CatView, Cat> { cell, indexPath, cat in
            cell.cat = cat
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<FooterSupplementaryView>(
            elementKind: UICollectionView.elementKindSectionFooter
        )
        
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, cat) -> CatView in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cat)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, index in
            collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
        }

        return dataSource
    }

    private func applySnapshot(cats: [Cat] = [], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.default])
        if !cats.isEmpty {
            snapshot.appendItems(cats)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func reload(_ cats: [Cat]) {
        guard !cats.isEmpty else { return }
        applySnapshot(cats: cats)
    }
}

extension CatalogViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cat = dataSource.itemIdentifier(for: indexPath)
        viewModel?.getDetails(for: cat?.imageId ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            viewModel?.nextPage()
        }
    }
}
