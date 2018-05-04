//
//  ViewController.swift
//  XDPlayer
//
//  Created by duan on 05/03/2018.
//  Copyright (c) 2018 monk-studio.com. All rights reserved.
//

import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import XDPlayer


class ViewController: UIViewController {
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton.init(type: .system)
        button.setTitle("Play", for: [])
        view.addSubview(button)
        button.centerInSuperview()

        button.rx.tap
            .subscribe { _ in
                let videoURL = URL(string: "https://www.quirksmode.org/html5/videos/big_buck_bunny.mp4")!
                XDPlayer.play(videoURL)
            }
            .disposed(by: disposeBag)
    }
}
