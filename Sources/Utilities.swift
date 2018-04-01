//
//  Utilities.swift
//  XDPlayer
//
//  Created by duan on 16/9/20.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

extension UIImage {
	class func bundledImage(named: String) -> UIImage? {
		let bundle = Bundle(for: XDPlayer().classForCoder)
		return UIImage(named: named, in: bundle, compatibleWith: nil)
	}
}
