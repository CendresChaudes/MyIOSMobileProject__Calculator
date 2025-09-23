//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Роман on 15.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

protocol ICalculatorButton {

    var buttons: [CalculatorButton.Button] { get }
}

struct CalculatorButton {

    enum Button {

        enum Operation {

            enum Base {
                case clear
                case changeSign
                case percentage
                case decimal
                case info
            }

            enum Algebraic {
                case add
                case subtract
                case multiply
                case divide
                case equal
            }
        }

        case number(Int)
        case baseOperation(Operation.Base)
        case algebraicOperation(Operation.Algebraic)
    }
}

// MARK: - CustomStringConvertible

extension CalculatorButton.Button: CustomStringConvertible {

    var description: String {
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
            case .info:
                return "?"
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
            case .equal:
                return "="
            }
        }
    }
}

// MARK: - ICalculatorButton

extension CalculatorButton: ICalculatorButton {

    var buttons: [CalculatorButton.Button] {
        [
            .baseOperation(.clear),
            .baseOperation(.changeSign),
            .baseOperation(.percentage),
            .algebraicOperation(.divide),
            .number(7),
            .number(8),
            .number(9),
            .algebraicOperation(.multiply),
            .number(4),
            .number(5),
            .number(6),
            .algebraicOperation(.subtract),
            .number(1),
            .number(2),
            .number(3),
            .algebraicOperation(.add),
            .baseOperation(.info),
            .number(0),
            .baseOperation(.decimal),
            .algebraicOperation(.equal),
        ]
    }
}
