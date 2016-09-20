//
//  XDPlayer.swift
//  XDPlayer-Demo
//
//  Created by 闻端 on 16/6/24.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

public class XDPlayer {
	public static func play(url: URL, themeColor: UIColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.1137254902, alpha: 1)) {
		let vc = XDPlayerViewController(url: url, themeColor: themeColor)
		WOMaintainer.show(vc: vc)
	}
	
	public static func stop(completion: (() -> ())?) {
		WOMaintainer.dismiss(completion: completion)
	}
}
