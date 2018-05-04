//
//  Utils.swift
//  XPlayer
//
//  Created by duan on 16/9/20.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

extension UIImage {
    static func bundleImage(_ name: String) -> UIImage? {
        let frameworkBundle = Bundle.init(for: XPlayer.self)
        guard
            let url = frameworkBundle.resourceURL?.appendingPathComponent("XPlayer.bundle"),
            let bundle = Bundle.init(url: url)
            else { return nil }
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}

extension CGSize {
    static func square(_ border: CGFloat) -> CGSize {
        return CGSize(width: border, height: border)
    }
}
