//
//  AppDelegate.swift
//  Calculator
//
//  Created by Роман on 04.09.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		true
	}

	// MARK: - Lifecycle

	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		return UISceneConfiguration(
			name: "Default Configuration",
			sessionRole: connectingSceneSession.role
		)
	}
}
