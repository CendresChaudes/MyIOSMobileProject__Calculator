//
//  SceneDelegate.swift
//  Calculator
//
//  Created by Роман on 04.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Internal properties

    var window: UIWindow?

    // MARK: - Lifecycle

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainAssembly.assemble() as! UIViewController
        window?.makeKeyAndVisible()
        window?.backgroundColor = Asset.background.color
    }
}
