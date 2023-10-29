//
//  SceneDelegate.swift
//  JoyDevBookApp
//
//  Created by Дмитрий Болучевских on 26.10.2023.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    static let container = Container()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScrene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScrene)
        Container.loggingFunction = nil
        SceneDelegate.container.registerDependencies()
        
        appCoordinator = SceneDelegate.container.resolve(AppCoordinator.self)!
        appCoordinator.window = window
        appCoordinator.start()
    }
}

