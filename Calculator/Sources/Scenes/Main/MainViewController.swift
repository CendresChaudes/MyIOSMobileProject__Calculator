//
//  ViewController.swift
//  Calculator
//
//  Created by Роман on 04.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

#if DEBUG
    import SwiftUI
#endif

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        let button = ButtonFactory.makeButton(title: "Test", variant: .accent)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#if DEBUG
    struct ViewControllerProvider: PreviewProvider {
        static var previews: some View {
            Group {
                MainViewController().preview()
            }
        }
    }
#endif
