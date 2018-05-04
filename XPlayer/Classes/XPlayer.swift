//
//  XPlayer.swift
//  XPlayer
//
//  Created by duan on 16/6/24.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

public class XPlayer: NSObject {
	public static func play(_ url: URL, themeColor: UIColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.1137254902, alpha: 1)) {
		let vc = XPlayerViewController(url: url, themeColor: themeColor)
		WOMaintainer.show(vc: vc)
	}
	
	public static func dismiss(completion: (() -> ())? = nil) {
		WOMaintainer.dismiss(completion: completion)
	}
}
