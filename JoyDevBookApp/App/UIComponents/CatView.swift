//
//  CatView.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 28.10.2023.
//

import DataLayer
import SDWebImage
import UIKit

final class CatView: ReusableCell<UIView> {
    var cat: Cat? {
        didSet {
            guard let cat else { return }
            setupCharacter(cat)
        }
    }
    
    private func setupCharacter(_ cat: Cat) {
        label.text = cat.imageId
        imageView.sd_setImage(
            with: URL(string: cat.imageUrl),
            placeholderImage: UIImage(named: "catPlaceholder"),
            context: [.imageThumbnailPixelSize: AppConstants.ImageThumbnailPixelSize.small]
        )
        
    }

    private let imageView = UIImageView()
    private let label = PaddingLabel()

    override func initialize() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.textColor = .black
        label.edgeInset = .init(top: 3, left: 6, bottom: 3, right: 6)
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.layer.borderWidth = 1.0
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        addSubview(imageView)
        imageView.addSubview(label)
        
        let fixedHeightConstraint = heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        fixedHeightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            fixedHeightConstraint,
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -16),
        ])
    }
}
