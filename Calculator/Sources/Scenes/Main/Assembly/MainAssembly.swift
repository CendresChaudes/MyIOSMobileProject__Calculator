//
//  MainAssembley.swift
//  Calculator
//
//  Created by Роман on 16.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

enum MainAssembly: IAssembly {

    static func assemble() -> IMainViewController {
        let controller = MainViewController()

        let presenter = MainPresenter(
            dependencies: .init(
                model: CalculatorButton(),
                view: controller
            )
        )

        controller.presenter = presenter

        return controller
    }
}
