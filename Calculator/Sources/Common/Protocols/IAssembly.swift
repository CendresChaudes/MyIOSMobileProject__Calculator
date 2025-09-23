//
//  IAssembly.swift
//  Calculator
//
//  Created by Роман on 22.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

protocol IAssembly {

    associatedtype T
    static func assemble() -> T
}
