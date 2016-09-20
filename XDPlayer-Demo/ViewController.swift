
//  ViewController.swift
//  XDPlayer-Demo
//
//  Created by 闻端 on 16/6/24.
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
			XDPlayer.play(url: URL(string: "https://cdn.xiaotaojiang.com/uploads/7c/1e7b570e20dfc52a3ab6de1d965df0/_.mp4")!)
		}
	}
	
}
