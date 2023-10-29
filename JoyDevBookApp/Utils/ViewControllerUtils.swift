//
//  ViewControllerUtils.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 27.10.2023.
//

import UIKit

struct ViewControllerUtils {
    static func setRootViewController(window: UIWindow?, viewController: UIViewController, withAnimation: Bool) {
        if !withAnimation {
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
            return
        }
        
        if let snapshot = window?.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()

            UIView.animate(withDuration: 0.4) {
                snapshot.layer.opacity = 0
            } completion: { _ in
                snapshot.removeFromSuperview()
            }

        }
    }
}
