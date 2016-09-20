//
//  WOViewController+State.swift
//  XDPlayer-Demo
//
//  Created by 闻端 on 16/9/19.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import Foundation

extension WOViewController {
	func willEnterFullScreen() {
		self.toggleDissmissButtonAnimation(show: false)
		self.hangAroundPanGesture.isEnabled = false
		self.tapGesture.isEnabled = false
	}
	
	func didEnterFullScreen() {
		WOMaintainer.state = .Fullscreen
		self.transitionPanGesture.isEnabled = true
	}
	
	func willEnterPIP() {
		self.transitionPanGesture.isEnabled = false
	}
	
	func didEnterPIP() {
		WOMaintainer.state = .PIP
		self.tapGesture.isEnabled = true
		self.hangAroundPanGesture.isEnabled = true
		self.toggleDissmissButtonAnimation(show: true)
	}
	
	func didStartTransition() {
	}
	
	func didEnterOut() {
	}
}
