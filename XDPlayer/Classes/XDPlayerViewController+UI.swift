//
//  XDPlayerViewController+UI.swift
//  XDPlayer
//
//  Created by duan on 16/9/18.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit
import TinyConstraints


extension XDPlayerViewController {
	func setupUI() {
		addChildViewController(playerVC)
		playerVC.view.isUserInteractionEnabled = false
		view.insertSubview(playerVC.view, belowSubview: pipCloseButton)
        playerVC.didMove(toParentViewController: self)

		[topGradientLayer, bottomGradientLayer].forEach { (layer) in
			layer.opacity = 0
            self.view.layer.addSublayer(layer)
		}
		[playButtton, closeButton, fullScreenButton, timelineLabel].forEach { button in
			button.layer.zPosition = 10
			self.view.addSubview(button)
		}
		timelineViewContainer.translatesAutoresizingMaskIntoConstraints = false
		timelineView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(timelineViewContainer)
		timelineViewContainer.addSubview(timelineView)
		timelineView.addSubview(timelineProgressedView)
		timelineView.addSubview(timelineDotView)


        playerVC.view.edgesToSuperview()

        playButtton.size(CGSize.square(24))
        playButtton.leadingToSuperview(offset: 16)
        playButtton.bottomToSuperview(offset: -16)

        fullScreenButton.size(CGSize.square(24))
        fullScreenButton.trailingToSuperview(offset: 16)
        fullScreenButton.bottomToSuperview(offset: -16)

        closeButton.size(CGSize.square(24))
        closeButton.trailingToSuperview(offset: 16)
        closeButton.topToSuperview(offset: 32)

        timelineLabel.centerY(to: fullScreenButton)
        timelineLabel.trailingToLeading(of: fullScreenButton, offset: -16)

        timelineViewContainer.height(30)
        timelineViewContainer.leadingToTrailing(of: playButtton, offset: 16)
        timelineViewContainer.trailingToLeading(of: timelineLabel, offset: -16)
        timelineView.centerY(to: playButtton)

        timelineViewContainer.leading(to: timelineView)
        timelineViewContainer.trailing(to: timelineView)
        timelineViewContainer.centerY(to: timelineView)
        timelineView.height(2)

		timelineProgressedView.frame = CGRect(x: 0, y: 0, width: 0, height: 2)
		timelineDotView.frame = CGRect(x: -11 / 2, y: 2 / 2 - 11 / 2, width: 11, height: 11)

		view.backgroundColor = UIColor.black
        view.tintColor = UIColor.white
		playerVC.showsPlaybackControls = false
		playButtton.setImage(UIImage.bundleImage("play_24")?.withRenderingMode(.alwaysTemplate), for: [])
		playButtton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		playButtton.imageView?.contentMode = .scaleAspectFit
		fullScreenButton.setImage(UIImage.bundleImage("maximize_24")?.withRenderingMode(.alwaysTemplate), for: [])
		fullScreenButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
		fullScreenButton.imageView?.contentMode = .scaleAspectFit
		closeButton.setImage(UIImage.bundleImage("x_24")?.withRenderingMode(.alwaysTemplate), for: [])
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
