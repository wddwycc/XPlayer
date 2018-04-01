//
//  XDPlayerViewController+UI.swift
//  XDPlayer
//
//  Created by duan on 16/9/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

extension XDPlayerViewController {
	func setupUI() {
		addChildViewController(playerVC)
		playerVC.view.translatesAutoresizingMaskIntoConstraints = false
		playerVC.view.isUserInteractionEnabled = false
		view.insertSubview(playerVC.view, belowSubview: pipCloseButton)
		playerVC.didMove(toParentViewController: self)
		[topGradientLayer, bottomGradientLayer].forEach { [unowned self] (layer) in
			self.view.layer.addSublayer(layer)
			layer.opacity = 0
		}
		[playButtton, closeButton,
		 fullScreenButton, timelineLabel].forEach { [unowned self] button in
			button.translatesAutoresizingMaskIntoConstraints = false
			button.layer.zPosition = 10
			self.view.addSubview(button)
		}
		timelineViewContainer.translatesAutoresizingMaskIntoConstraints = false
		timelineView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(timelineViewContainer)
		timelineViewContainer.addSubview(timelineView)
		timelineView.addSubview(timelineProgressedView)
		timelineView.addSubview(timelineDotView)

		playerVC.view.topAnchor.constraint(equalTo: view.topAnchor).activate()
		playerVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).activate()
		playerVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).activate()
		playerVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).activate()
		
		playButtton.widthAnchor.constraint(equalToConstant: 20).activate()
		playButtton.heightAnchor.constraint(equalToConstant: 20).activate()
		playButtton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).activate()
		playButtton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).activate()
		
		fullScreenButton.widthAnchor.constraint(equalToConstant: 20).activate()
		fullScreenButton.heightAnchor.constraint(equalToConstant: 20).activate()
		fullScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).activate()
		fullScreenButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).activate()
		
		closeButton.widthAnchor.constraint(equalToConstant: 20).activate()
		closeButton.heightAnchor.constraint(equalToConstant: 20).activate()
		closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).activate()
		closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).activate()
		
		timelineLabel.centerYAnchor.constraint(equalTo: fullScreenButton.centerYAnchor, constant: 1).activate()
		timelineLabel.trailingAnchor.constraint(equalTo: fullScreenButton.leadingAnchor, constant: -6).activate()
		
		timelineViewContainer.heightAnchor.constraint(equalToConstant: 30).activate()
		timelineViewContainer.leadingAnchor.constraint(equalTo: playButtton.trailingAnchor, constant: 12).activate()
		timelineViewContainer.trailingAnchor.constraint(equalTo: timelineLabel.leadingAnchor, constant: -12).activate()
		timelineViewContainer.centerYAnchor.constraint(equalTo: playButtton.centerYAnchor).activate()
		
		timelineViewContainer.leadingAnchor.constraint(equalTo: timelineView.leadingAnchor).activate()
		timelineViewContainer.trailingAnchor.constraint(equalTo: timelineView.trailingAnchor).activate()
		timelineViewContainer.centerYAnchor.constraint(equalTo: timelineView.centerYAnchor).activate()
		timelineView.heightAnchor.constraint(equalToConstant: 2).activate()
		
		timelineProgressedView.frame = CGRect(x: 0, y: 0, width: 0, height: 2)
		timelineDotView.frame = CGRect(x: -11 / 2, y: 2 / 2 - 11 / 2, width: 11, height: 11)

		view.backgroundColor = UIColor.black
		playerVC.showsPlaybackControls = false
		playButtton.setImage(UIImage.bundledImage(named: "play"), for: .normal)
		playButtton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		playButtton.imageView?.contentMode = .scaleAspectFit
		fullScreenButton.setImage(UIImage.bundledImage(named: "fullscreen"), for: .normal)
		fullScreenButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		fullScreenButton.imageView?.contentMode = .scaleAspectFit
		closeButton.setImage(UIImage.bundledImage(named: "close"), for: .normal)
		closeButton.imageView?.contentMode = .scaleAspectFit
		timelineView.backgroundColor = UIColor(white: 1, alpha: 0.4)
		timelineProgressedView.backgroundColor = themeColor
		timelineDotView.backgroundColor = UIColor.white
		timelineView.layer.cornerRadius = 2
		timelineProgressedView.layer.cornerRadius = 2
		timelineDotView.layer.cornerRadius = 5.5
		timelineLabel.font = UIFont(name: "Avenir", size: 10)
		timelineLabel.textAlignment = .center
		timelineLabel.textColor = UIColor.white
		timelineLabel.text = "00:00 / 00:00"
		topGradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
		topGradientLayer.opacity = 0
		bottomGradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
		bottomGradientLayer.opacity = 0
		timelineViewContainer.isUserInteractionEnabled = false
	}
}

extension NSLayoutConstraint {
	func activate() {
		isActive = true
	}
}
