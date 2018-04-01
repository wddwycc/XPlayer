
//  ViewController.swift
//  XDPlayer-Demo
//
//  Created by duan on 16/6/24.
//  Copyright © 2016年 monk-studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let webView = UIWebView(frame: view.bounds)
		view.addSubview(webView)
		webView.loadRequest(URLRequest(url: URL(string: "http://apple.com")!))
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		delay(seconds: 2) {
            let url = URL(string: "https://www.quirksmode.org/html5/videos/big_buck_bunny.mp4")!
			XDPlayer.play(url: url)
		}
	}
	
}
