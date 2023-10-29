//
//  PaddingLabel.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 28.10.2023.
//

import UIKit

final class PaddingLabel: UILabel {

    public var edgeInset: UIEdgeInsets = .zero

    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
