//
//  Extensions.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 28.10.2023.
//

import UIKit

extension UICollectionViewLayout {
    static func createListLayout(header: Bool = false, footer: Bool = false) -> UICollectionViewLayout {
        let spacing: CGFloat = 6
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: spacing, trailing: 0)
        
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120)
        )
        var supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = []
        if header {
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            supplementaryItems.append(sectionHeader)
        }
        
        if footer {
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            
            supplementaryItems.append(sectionFooter)
        }
        
        section.boundarySupplementaryItems = supplementaryItems

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension UICollectionView.SupplementaryRegistration {
    public init(elementKind: String) {
        self.init(elementKind: elementKind, handler: { _, _, _ in })
    }
}
