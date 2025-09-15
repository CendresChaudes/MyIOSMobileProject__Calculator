//
//  Button.swift
//  Calculator
//
//  Created by Роман on 15.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import SwiftUI
import UIKit

extension UIViewController {
    struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }

    func preview() -> some View {
        Preview(viewController: self).edgesIgnoringSafeArea(.all)
    }
}
