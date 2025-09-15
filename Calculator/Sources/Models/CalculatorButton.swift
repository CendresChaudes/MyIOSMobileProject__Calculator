//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Роман on 15.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

enum CalculatorButton {

    enum Operation {

        enum Base {
            case clear
            case changeSign
            case percentage
            case decimal
        }

        enum Algebraic {
            case add
            case subtract
            case multiply
            case divide
        }
    }

    case number(Int)
    case baseOperation(Operation.Base)
    case algebraicOperation(Operation.Algebraic)
}

// MARK: - Title property

extension CalculatorButton {

    var title: String {
        switch self {
        case .number(let int):
            if int.description.count == 1 {
                return String(int)
            } else {
                fatalError("Integer must be one digit from 0 to 9")
            }
        case .baseOperation(let baseOperation):
            switch baseOperation {
            case .clear:
                return "AC"
            case .changeSign:
                return "±"
            case .percentage:
                return "%"
            case .decimal:
                return "."
            }
        case .algebraicOperation(let algebraicOperation):
            switch algebraicOperation {
            case .add:
                return "+"
            case .subtract:
                return "-"
            case .multiply:
                return "×"
            case .divide:
                return "÷"
            }
        }
    }
}
