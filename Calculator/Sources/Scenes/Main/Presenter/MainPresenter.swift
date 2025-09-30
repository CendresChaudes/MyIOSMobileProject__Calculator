//
//  MainPresenter.swift
//  Calculator
//
//  Created by Роман on 16.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import Foundation

protocol IMainPresenter {

    var buttons: [CalculatorButton.Button] { get }
    func handleNumberButton(with number: Int)
    func handleSimpleBaseOperationButton(with operation: CalculatorButton.Button.Operation.Base)
    func handleInfoButton() -> (title: String, message: String)
    func handleAlgebraicOperationButton(with operation: CalculatorButton.Button.Operation.Algebraic)
}

final class MainPresenter {

    private let model: ICalculatorButton
    private unowned let view: IMainViewController

    private var previousNumber: Int?
    private var previousAlgebraicOperation: CalculatorButton.Button.Operation.Algebraic?
    private var tempValue = ""
    private var displayText = ""
    private let ERROR_MESSAGE = "Ошибка"

    struct Dependencies {

        let model: ICalculatorButton
        let view: IMainViewController
    }

    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.view = dependencies.view
    }
}

// MARK: - IMainPresenter

extension MainPresenter: IMainPresenter {

    var buttons: [CalculatorButton.Button] {
        model.buttons
    }

    func handleNumberButton(with number: Int) {
        if displayText == ERROR_MESSAGE || (previousAlgebraicOperation != nil && previousNumber == nil)
            || previousAlgebraicOperation == .equal {
            displayText = ""
        }

        previousNumber = number
        let number = String(number)
        displayText += number
        updateDisplay(with: displayText)
    }

    func handleSimpleBaseOperationButton(with operation: CalculatorButton.Button.Operation.Base) {
        switch operation {
        case .clear:
            handleClearButton()
        case .changeSign:
            handleChangeSignButton()
        case .percent:
            handlePercentButton()
        case .decimal:
            handleDecimalButton()
        default:
            fatalError(#function + ": unsupported operation")
        }
    }

    func handleInfoButton() -> (title: String, message: String) {
        (title: "Информация", message: "Разработчик: @CendresChaudes")
    }

    private func handleClearButton() {
        let text = ""

        tempValue = text
        displayText = text
        updateDisplay(with: displayText)
        previousAlgebraicOperation = nil
        previousNumber = nil
    }

    func handleAlgebraicOperationButton(with operation: CalculatorButton.Button.Operation.Algebraic) {
        guard displayText != ERROR_MESSAGE else { return }
        guard let newValue = Double(displayText) else { return }

        if operation == .equal {
            let oldValue = Double(tempValue) ?? 0

            var sum = oldValue
            switch previousAlgebraicOperation {
            case .sum:
                sum += newValue
            case .subtract:
                sum -= newValue
            case .multiply:
                sum *= newValue
            case .divide:
                sum /= newValue
            default:
                fatalError(#function + ": unsupported operation")
            }

            let isInt = sum.truncatingRemainder(dividingBy: 1) == 0
            displayText = String(format: isInt ? "%.0f" : String(sum), sum)
            updateDisplay(with: displayText)
            previousAlgebraicOperation = .equal
            tempValue = ""
            return
        } else if tempValue == "" {
            let oldValue: Double = 0

            var result = oldValue
            switch operation {
            case .sum:
                previousAlgebraicOperation = .sum
                result += newValue
            case .subtract:
                previousAlgebraicOperation = .subtract
                result -= newValue
            case .multiply:
                previousAlgebraicOperation = .multiply
                result *= newValue
            case .divide:
                previousAlgebraicOperation = .divide
                result /= newValue
            default:
                fatalError(#function + ": unsupported operation")
            }

            let isInt = result.truncatingRemainder(dividingBy: 1) == 0
            tempValue = String(format: isInt ? "%.0f" : String(result), result)
        } else if operation == .divide && newValue == 0 {
            tempValue = ERROR_MESSAGE
            updateDisplay(with: ERROR_MESSAGE)
            return
        } else {
            let oldValue = Double(tempValue) ?? 0

            var result = oldValue
            switch previousAlgebraicOperation {
            case .sum:
                result += newValue
            case .subtract:
                result -= newValue
            case .multiply:
                result *= newValue
            case .divide:
                result /= newValue
            default:
                fatalError(#function + ": unsupported operation")
            }

            previousAlgebraicOperation = operation
            let isInt = result.truncatingRemainder(dividingBy: 1) == 0
            tempValue = String(format: isInt ? "%.0f" : String(result), result)
        }

        previousNumber = nil
        displayText = tempValue
        updateDisplay(with: displayText)
    }

    private func handleChangeSignButton() {
        guard Double(displayText) != nil && !displayText.isEmpty else {
            displayText = ERROR_MESSAGE
            updateDisplay(with: displayText)
            return
        }

        if displayText.first == "-" {
            displayText.removeFirst()
        } else {
            displayText = "-" + displayText
        }

        updateDisplay(with: displayText)
    }

    private func handlePercentButton() {
        guard let value = Double(displayText) else {
            displayText = ERROR_MESSAGE
            updateDisplay(with: displayText)
            return
        }

        if displayText != "0" {
            displayText = "\(Decimal(value) * 0.01)"
        }

        updateDisplay(with: displayText)
    }

    private func handleDecimalButton() {
        if displayText == "" {
            displayText = "0."
        } else if Double(displayText) != nil && !displayText.contains(".") {
            displayText += "."
        } else if !displayText.contains(".") {
            displayText = ERROR_MESSAGE
        }

        updateDisplay(with: displayText)
    }

    private func updateDisplay(with text: String) {
        view.setDisplay(text: text)
    }
}
