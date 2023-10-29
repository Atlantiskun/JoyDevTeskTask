//
//  ReusableCell.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 28.10.2023.
//

import UIKit

open class CollectionViewCell: UICollectionViewCell {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) isn not available")
    }
    
    open func initialize() {}
}

open class ReusableCell<View: UIView>: CollectionViewCell {
    
    var view: View!

    open override func initialize() {
        super.initialize()

        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        self.view = view
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
