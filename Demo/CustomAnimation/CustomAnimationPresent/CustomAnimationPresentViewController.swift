//
//  CustomAnimationPresentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPresentViewController<Out: CustomAnimationPresentViewOutput>: ARCHViewController<CustomAnimationPresentState, Out>, UIViewControllerTransitioningDelegate {

    var imageView = UIImageView()
    var closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.35)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2.0 / 3.0),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0 / 2.0),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(self.closeButtonDidTap(_:)), for: .touchUpInside)

        imageView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8.0)
        ])
    }

    override func render(state: State) {
        super.render(state: state)

        imageView.image = state.image
    }

    // ARCHInteractiveTransitionDelegate

    override var closeGestureRecognizer: UIGestureRecognizer? {
        return UIPanGestureRecognizer()
    }

    override func progress(for recognizer: UIGestureRecognizer) -> CGFloat {
        guard let recognizer = recognizer as? UIPanGestureRecognizer else {
            return 0.0
        }

        let maxTranslation: CGFloat = 200.0
        let verticalTranslation = Double(recognizer.translation(in: recognizer.view?.superview).y)
        let horizontalTranslation = Double(recognizer.translation(in: recognizer.view?.superview).x)
        let translation = CGFloat(sqrt(pow(verticalTranslation, 2.0) + pow(horizontalTranslation, 2.0)))

        return min(translation / maxTranslation, 1.0)
    }

    // MARK: - Private

    @objc
    private func closeButtonDidTap(_ sender: UIButton) {
        output?.didTapCloseButton()
    }
}