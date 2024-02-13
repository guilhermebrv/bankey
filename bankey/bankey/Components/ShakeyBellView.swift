//
//  ShakeyBellView.swift
//  bankey
//
//  Created by Guilherme Viana on 13/02/2024.
//

import UIKit

class ShakeyBellView: UIView {
	
	lazy var shakeyBellImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
		imageView.addGestureRecognizer(singleTap)
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	
	lazy var notificationButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .systemRed
		button.layer.cornerRadius = 16/2
		button.titleLabel?.font = .systemFont(ofSize: 13)
		button.setTitle("9", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(imageViewTapped), for: .touchUpInside)
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: 48, height: 48)
	}
}

extension ShakeyBellView {
	private func addElements() {
		addSubview(shakeyBellImageView)
		addSubview(notificationButton)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			shakeyBellImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			shakeyBellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			shakeyBellImageView.widthAnchor.constraint(equalToConstant: 24),
			shakeyBellImageView.heightAnchor.constraint(equalToConstant: 24),
			
			notificationButton.topAnchor.constraint(equalTo: shakeyBellImageView.topAnchor),
			notificationButton.leadingAnchor.constraint(equalTo: shakeyBellImageView.trailingAnchor, constant: -10),
			notificationButton.widthAnchor.constraint(equalToConstant: 16),
			notificationButton.heightAnchor.constraint(equalToConstant: 16),
		])
	}
}

extension ShakeyBellView {
	@objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
		shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
	}
	
	private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
	   let numberOfFrames: Double = 6
	   let frameDuration = Double(1/numberOfFrames)
	   
	   shakeyBellImageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

	   UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
		 animations: {
		   UIView.addKeyframe(withRelativeStartTime: 0.0,
							  relativeDuration: frameDuration) {
			   self.shakeyBellImageView.transform = CGAffineTransform(rotationAngle: -angle)
		   }
		   UIView.addKeyframe(withRelativeStartTime: frameDuration,
							  relativeDuration: frameDuration) {
			   self.shakeyBellImageView.transform = CGAffineTransform(rotationAngle: +angle)
		   }
		   UIView.addKeyframe(withRelativeStartTime: frameDuration*2,
							  relativeDuration: frameDuration) {
			   self.shakeyBellImageView.transform = CGAffineTransform(rotationAngle: -angle)
		   }
		   UIView.addKeyframe(withRelativeStartTime: frameDuration*3,
							  relativeDuration: frameDuration) {
			   self.shakeyBellImageView.transform = CGAffineTransform(rotationAngle: +angle)
		   }
		   UIView.addKeyframe(withRelativeStartTime: frameDuration*4,
							  relativeDuration: frameDuration) {
			   self.shakeyBellImageView.transform = CGAffineTransform(rotationAngle: -angle)
		   }
		   UIView.addKeyframe(withRelativeStartTime: frameDuration*5,
							  relativeDuration: frameDuration) {
			   self.shakeyBellImageView.transform = CGAffineTransform.identity
		   }
		 },
		 completion: nil
	   )
   }
}

extension UIView {
	func setAnchorPoint(_ point: CGPoint) {
		var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
		var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

		newPoint = newPoint.applying(transform)
		oldPoint = oldPoint.applying(transform)

		var position = layer.position

		position.x -= oldPoint.x
		position.x += newPoint.x

		position.y -= oldPoint.y
		position.y += newPoint.y

		layer.position = position
		layer.anchorPoint = point
	}
}
