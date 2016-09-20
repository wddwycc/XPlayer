//
//  WindowOverlayViewController.swift
//  XDPlayer-Demo
//
//  Created by 闻端 on 16/6/24.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

/// Window Overlay View Controller
class WOViewController: UIViewController {
	var PIPRect: CGRect = WOMaintainerInfo.pipRect(size: WOMaintainerInfo.pipDefaultSize)
	// UI
	let pipCloseButton = UIButton(type: .custom)
	// Constraint
	var containerLeadingConstraint: NSLayoutConstraint!
	var containerTrailingConstraint: NSLayoutConstraint!
	var containerTopConstraint: NSLayoutConstraint!
	var containerBottomConstraint: NSLayoutConstraint!
	// Gesture
	var transitionPanGesture: UIPanGestureRecognizer!
	var hangAroundPanGesture: UIPanGestureRecognizer!
	var tapGesture: UITapGestureRecognizer!
	let panningLength: CGFloat = 400
	// State
	var validatingPanning = false
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// UI
		view.layer.shadowOpacity = 0.3
		view.layer.shadowOffset = CGSize(width: 0, height: 0)
		view.layer.rasterizationScale = UIScreen.main.scale
		view.layer.shouldRasterize = true
		view.addSubview(pipCloseButton)
		pipCloseButton.backgroundColor = UIColor(white: 0, alpha: 0.4)
		pipCloseButton.layer.cornerRadius = 12
		pipCloseButton.clipsToBounds = true
		pipCloseButton.translatesAutoresizingMaskIntoConstraints = false
		pipCloseButton.alpha = 0
		pipCloseButton.layer.rasterizationScale = UIScreen.main.scale
		pipCloseButton.layer.shouldRasterize = true
		let closeIconImageView = UIImageView()
		closeIconImageView.image = UIImage.bundledImage(named: "close_small")
		closeIconImageView.alpha = 0.6
		closeIconImageView.translatesAutoresizingMaskIntoConstraints = false
		pipCloseButton.addSubview(closeIconImageView)
		pipCloseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).activate()
		pipCloseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).activate()
		pipCloseButton.widthAnchor.constraint(equalToConstant: 24).activate()
		pipCloseButton.heightAnchor.constraint(equalToConstant: 24).activate()
		closeIconImageView.centerXAnchor.constraint(equalTo: pipCloseButton.centerXAnchor).activate()
		closeIconImageView.centerYAnchor.constraint(equalTo: pipCloseButton.centerYAnchor).activate()
		closeIconImageView.widthAnchor.constraint(equalToConstant: 12).activate()
		closeIconImageView.heightAnchor.constraint(equalToConstant: 12).activate()
		// Action
		pipCloseButton.addTarget(self, action: #selector(didPressPipCloseButton), for: .touchUpInside)
		transitionPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTransitionPan))
		view.addGestureRecognizer(transitionPanGesture)
		hangAroundPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleHangAroundPan))
		hangAroundPanGesture.isEnabled = false
		view.addGestureRecognizer(hangAroundPanGesture)
		tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		view.addGestureRecognizer(tapGesture)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
}

// MARK: Action
extension WOViewController {
	@objc func handleTransitionPan(gesture: UIPanGestureRecognizer) {
		guard let window = UIApplication.shared.keyWindow else { return }
		let translationY = gesture.translation(in: window).y
		let targetTranslationY = min(max(translationY, 0), panningLength)
		let percentage = min(1, targetTranslationY / self.panningLength)
		switch gesture.state {
		case .changed:
			if percentage > 0 && !validatingPanning {
				validatingPanning = true
				didStartTransition()
			}
			self.updateFrame(
				rect: inBetweenFrame(
					outerFrame: UIScreen.main.bounds,
					innerFrame: self.PIPRect, percentage: percentage
				)
			)
		case .ended:
			self.validatingPanning = false
			if percentage < 0.3 {
				var speed = gesture.velocity(in: window).y
				if speed < 0 { speed = -speed }
				if speed > 0 { speed = 0 }
				speed = speed / ( panningLength * percentage )
				self.willEnterFullScreen()
				self.updateFrame(rect: UIScreen.main.bounds)
				UIView.animate(
					withDuration: 0.3,
					delay: 0,
					usingSpringWithDamping: 1,
					initialSpringVelocity: speed,
					options: [],
					animations: {
						window.layoutIfNeeded()
					},
					completion: { [weak self] _ in
						self?.didEnterFullScreen()
					}
				)
			} else {
				var speed = gesture.velocity(in: window).y
				if speed < 0 { speed = 0 }
				speed = speed / ( panningLength * (1 - percentage) )
				self.willEnterPIP()
				self.updateFrame(rect: self.PIPRect)
				UIView.animate(
					withDuration: 0.3,
					delay: 0,
					usingSpringWithDamping: 1,
					initialSpringVelocity: speed,
					options: [],
					animations: {
						window.layoutIfNeeded()
					},
					completion: { _ in
						self.didEnterPIP()
					}
				)
			}
		default: break
		}
	}
	
	@objc func handleHangAroundPan(gesture: UIPanGestureRecognizer) {
		guard let window = UIApplication.shared.keyWindow else { return }
		if WOMaintainer.state != .PIP { return }
		let locationInWindow = gesture.location(in: window)
		let targetRect = CGRect(x: locationInWindow.x - self.PIPRect.width / 2, y: locationInWindow.y - self.PIPRect.height / 2, width: self.PIPRect.width, height: self.PIPRect.height)
		switch gesture.state {
		case .began:
			self.updateFrame(rect: insideFrame(objectFrame: targetRect, superViewSize: UIScreen.main.bounds.size, inset: 0))
			UIView.animate(withDuration: 0.3, animations: { [weak self] in
				self?.view.layoutIfNeeded()
			})
		case .changed:
			self.updateFrame(rect: insideFrame(objectFrame: targetRect, superViewSize: UIScreen.main.bounds.size, inset: 0))
		case .ended:
			let inside = insideFrame(objectFrame: self.view.frame, superViewSize: UIScreen.main.bounds.size, inset: 12)
			let sided = sidedFrame(objectFrame: inside, superViewSize: UIScreen.main.bounds.size)
			self.updateFrame(rect: sided)
			UIView.animate(withDuration: 0.2, animations: {
				window.layoutIfNeeded()
			})
		default: break
		}
	}
	
	@objc func handleTap(gesture: UITapGestureRecognizer) {
		guard let window = UIApplication.shared.keyWindow else { return }
		if gesture.state != .ended { return }
		if WOMaintainer.state == .PIP {
			WOMaintainer.state = .Fullscreen
			self.willEnterFullScreen()
			self.updateFrame(rect: UIScreen.main.bounds)
			UIView.animate(withDuration: 0.3, animations: {
				window.layoutIfNeeded()
			}) { [weak self] _ in
				self?.didEnterFullScreen()
			}
		}
	}
	
	@objc func didPressPipCloseButton() {
		WOMaintainer.dismiss(completion: nil)
	}
}

// MARK: Animation
extension WOViewController {
	func toggleDissmissButtonAnimation(show: Bool) {
		UIView.animate(withDuration: 0.3) { [weak self] in
			self?.pipCloseButton.alpha = show ? 1 : 0
		}
	}
}

// MARK: Utils
extension WOViewController {
	func updateFrame(rect: CGRect) {
		self.containerLeadingConstraint.constant = rect.origin.x
		self.containerTrailingConstraint.constant = -(UIScreen.main.bounds.width - rect.size.width - rect.origin.x)
		self.containerTopConstraint.constant = rect.origin.y
		self.containerBottomConstraint.constant = -(UIScreen.main.bounds.height - rect.size.height - rect.origin.y)
	}
}

private func inBetweenFrame(outerFrame: CGRect, innerFrame: CGRect, percentage: CGFloat) -> CGRect {
	let x = outerFrame.origin.x + (innerFrame.origin.x - outerFrame.origin.x) * percentage
	let y = outerFrame.origin.y + (innerFrame.origin.y - outerFrame.origin.y) * percentage
	let width = outerFrame.size.width - (outerFrame.size.width - innerFrame.size.width) * percentage
	let height = outerFrame.size.height - (outerFrame.size.height - innerFrame.size.height) * percentage
	return CGRect(x: x, y: y, width: width, height: height)
}

private func insideFrame(objectFrame: CGRect, superViewSize: CGSize, inset: CGFloat) -> CGRect {
	var targetFrame = objectFrame
	if targetFrame.origin.x < inset {
		targetFrame.origin.x = inset
	}
	if targetFrame.origin.x + targetFrame.size.width > superViewSize.width - inset {
		targetFrame.origin.x = superViewSize.width - inset - targetFrame.size.width
	}
	if targetFrame.origin.y < inset {
		targetFrame.origin.y = inset
	}
	if targetFrame.origin.y + targetFrame.size.height > superViewSize.height - inset {
		targetFrame.origin.y = superViewSize.height - inset - targetFrame.size.height
	}
	return targetFrame
}

private func sidedFrame(objectFrame: CGRect, superViewSize: CGSize) -> CGRect {
	var targetFrame = objectFrame
	let minOffset: CGFloat = 12
	let left = objectFrame.midX < superViewSize.width / 2
	if left {
		targetFrame.origin.x = 12
	} else {
		targetFrame.origin.x = superViewSize.width - minOffset - objectFrame.width
	}
	return targetFrame
}
