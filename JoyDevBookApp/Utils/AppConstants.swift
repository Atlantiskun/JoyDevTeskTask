//
//  AppConstants.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 29.10.2023.
//

import Foundation

public enum AppConstants {
    public enum ImageThumbnailPixelSize {
        public static let small: CGSize = .init(width: 160, height: 160)
        public static let middle: CGSize = .init(width: 320, height: 320)
        public static let large: CGSize = .init(width: 480, height: 480)
    }
    
    public enum Padding {
        public static let small: CGFloat = 8
        public static let medium: CGFloat = 16
        public static let large: CGFloat = 32
    }
}
