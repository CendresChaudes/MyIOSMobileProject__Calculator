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

protocol IMainViewController: AnyObject {

    func setDisplay(text: String)
}

final class MainViewController: UIViewController {

    var presenter: IMainPresenter!

    private var container: Container!
    private var displayText: UILabel!
    private var keyboard: UICollectionView!
    private var keyboardHeightConstraint: NSLayoutConstraint!

    private let GAP: CGFloat = 12
    private let COLUMNS_COUNT = 4
    private var calculatorCellSize: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateKeyboardHeight()
    }

    private func setupUI() {
        // Container
        container = Container()
        view.addSubview(container)
        container.setupConstraints(view: view)

        // Keyboard
        keyboard = makeKeyboard()
        keyboardHeightConstraint = keyboard.heightAnchor.constraint(equalToConstant: 0)
        keyboardHeightConstraint.isActive = true
        container.addSubview(keyboard)
        setupKeyboardConstraints()

        // Display
        let displayContainer = UIView()
        displayText = makeDisplayText()
        displayContainer.addSubview(displayText)
        container.addSubview(displayContainer)

        setupDisplayConstraints(
            displayContainer: displayContainer,
            displayText: displayText
        )
    }

    private func makeKeyboard() -> UICollectionView {
        let keyboard = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )

        keyboard.delegate = self
        keyboard.dataSource = self
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        keyboard.backgroundColor = .clear

        keyboard.register(
            CalculatorViewCell.self,
            forCellWithReuseIdentifier: CalculatorViewCell.REUSE_ID
        )

        return keyboard
    }

    private func setupKeyboardConstraints() {
        NSLayoutConstraint.activate([
            keyboardHeightConstraint,
            keyboard.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            keyboard.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            keyboard.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])
    }

    private func updateKeyboardHeight() {
        let rowsCount = ceil(Double(presenter.buttons.count) / Double(COLUMNS_COUNT))
        let summaryColumnGap = GAP * (CGFloat(rowsCount) - 1)
        let newHeight = calculatorCellSize * CGFloat(rowsCount) + summaryColumnGap

        keyboardHeightConstraint.constant = newHeight
    }

    private func makeDisplayText() -> UILabel {
        let displayText = UILabel()

        displayText.textAlignment = .right
        displayText.font = .systemFont(ofSize: 60, weight: .bold)
        displayText.textColor = Asset.text.color

        return displayText
    }

    private func setupDisplayConstraints(
        displayContainer: UIView,
        displayText: UILabel
    ) {
        displayContainer.translatesAutoresizingMaskIntoConstraints = false
        displayText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Display container
            displayContainer.topAnchor.constraint(equalTo: container.topAnchor),
            displayContainer.bottomAnchor.constraint(equalTo: keyboard.topAnchor),
            displayContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            displayContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            // Display text
            displayText.bottomAnchor.constraint(equalTo: displayContainer.bottomAnchor, constant: -40),
            displayText.leadingAnchor.constraint(equalTo: displayContainer.leadingAnchor),
            displayText.trailingAnchor.constraint(equalTo: displayContainer.trailingAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.buttons.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CalculatorViewCell.REUSE_ID,
                for: indexPath
            )
                as? CalculatorViewCell
        else {
            fatalError("Failed to dequeue CalculatorViewCell in MainViewController.")
        }

        cell.configure(with: presenter.buttons[indexPath.item])
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let summaryRowGap = GAP * (CGFloat(COLUMNS_COUNT) - 1)
        calculatorCellSize = (keyboard.bounds.width - summaryRowGap) / CGFloat(COLUMNS_COUNT)
        return CGSize(width: calculatorCellSize, height: calculatorCellSize)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let button = presenter.buttons[indexPath.item]
        presenter.updateDisplay(with: button.description)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        GAP
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        GAP
    }
}

// MARK: - IMainViewController

extension MainViewController: IMainViewController {

    func setDisplay(text: String) {
        displayText.text = text
    }
}

// MARK: - Debug

#if DEBUG
    struct ViewControllerProvider: PreviewProvider {
        static var previews: some View {
            Group {
                MainViewController().preview()
            }
        }
    }
#endif
