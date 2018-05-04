//
//  WOMaintainer.swift
//  XPlayer
//
//  Created by duan on 16/6/24.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit
import TinyConstraints


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
		return CGRect(x: screenSize.width - offset - size.width,
                      y: screenSize.height - offset - size.height,
                      width: size.width,
                      height: size.height)
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

        vc.leadingConstraint = vc.view.leadingToSuperview()
        vc.topConstraint = vc.view.topToSuperview()
        vc.trailingConstraint = vc.view.trailingToSuperview()
        vc.bottomConstraint = vc.view.bottomToSuperview()

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
