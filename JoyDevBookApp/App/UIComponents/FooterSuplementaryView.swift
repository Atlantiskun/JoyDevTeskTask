//
//  FooterSuplementaryView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 28.10.2023.
//

import UIKit

final class FooterSupplementaryView: ReusableCell<UIView> {
    let left = UIView()
    let right = UIView()
    
    var shimmeringAnimatedItems: [UIView] {
        [left, right]
    }

    override func initialize() {
        left.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false
        left.backgroundColor = .lightGray
        right.backgroundColor = .lightGray
        
        addSubview(left)
        addSubview(right)
        
        NSLayoutConstraint.activate([
            left.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstants.Padding.small),
            right.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstants.Padding.small),
            
            left.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -AppConstants.Padding.medium),
            right.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -AppConstants.Padding.medium),
            
            left.heightAnchor.constraint(equalToConstant: 200),
            right.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
