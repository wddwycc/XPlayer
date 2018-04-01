//
//  WOMaintainer.swift
//  XDPlayer
//
//  Created by duan on 16/6/24.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

enum WOState {
	case fullscreen
	case pip
	case out
}

struct WOMaintainerInfo {
	static let pipDefaultSize = CGSize(width: 170, height: 96)
	static func pipRect(size: CGSize) -> CGRect {
		let screenSize = UIScreen.main.bounds.size
		let offset: CGFloat = 12
		return CGRect(x: screenSize.width - offset - size.width, y: screenSize.height - offset - size.height, width: size.width, height: size.height)
	}
}

class WOMaintainer {
	static var state: WOState = .out
	static var vc: WOViewController?
	static func show(vc: WOViewController) {
		guard let window = UIApplication.shared.keyWindow else { return }
		if WOMaintainer.state != .out {
			dismiss(completion: {
				WOMaintainer.show(vc: vc)
			})
			return
		}
		WOMaintainer.vc = vc
		vc.view.alpha = 0
		UIView.animate(withDuration: 0.3) {
			WOMaintainer.vc!.view.alpha = 1
		}
		window.addSubview(WOMaintainer.vc!.view)
		vc.view.translatesAutoresizingMaskIntoConstraints = false
		vc.containerLeadingConstraint = NSLayoutConstraint(item: vc.view, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1, constant: 0)
		vc.containerTrailingConstraint = NSLayoutConstraint(item: vc.view, attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailing, multiplier: 1, constant: 0)
		vc.containerTopConstraint = NSLayoutConstraint(item: vc.view, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1, constant: 0)
		vc.containerBottomConstraint = NSLayoutConstraint(item: vc.view, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier: 1, constant: 0)
		window.addConstraints([
			vc.containerLeadingConstraint,
			vc.containerTrailingConstraint,
			vc.containerTopConstraint,
			vc.containerBottomConstraint
		])
		WOMaintainer.state = .fullscreen
	}
	
	static func dismiss(completion: (()->())?) {
        guard let vc = WOMaintainer.vc else { return }
		UIView.animate(withDuration: 0.3, animations: {
			vc.view.alpha = 0
		}) { _ in
			vc.view.removeFromSuperview()
			vc.didEnterOut()
			WOMaintainer.vc = nil
			WOMaintainer.state = .out
			completion?()
		}
	}
}

func delay(seconds: Double, completion:@escaping ()->()) {
	let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
	DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
		completion()
	})
}
