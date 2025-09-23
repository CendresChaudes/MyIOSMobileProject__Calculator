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
    //
}

final class MainViewController: UIViewController, IMainViewController {

    var presenter: IMainPresenter!

    private var container: Container!
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
    }

    private func makeKeyboard() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = GAP
        flowLayout.minimumLineSpacing = GAP

        let keyboard = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
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
            keyboard.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }

    private func updateKeyboardHeight() {
        let rowsCount = ceil(Double(presenter.buttons.count) / Double(COLUMNS_COUNT))
        let summaryColumnGap = GAP * (CGFloat(rowsCount) - 1)
        let newHeight = calculatorCellSize * CGFloat(rowsCount) + summaryColumnGap

        keyboardHeightConstraint.constant = newHeight
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: CalculatorViewCell.REUSE_ID,
                for: indexPath
            ) as! CalculatorViewCell

        cell.configure(with: presenter.buttons[indexPath.item])
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
