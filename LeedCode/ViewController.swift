//
//  ViewController.swift
//  LeedCode
//
//  Created by 李臣臣 on 2020/9/1.
//  Copyright © 2020 李臣臣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let leedCode = LeedCode()
        var mutableArrar = [2, 3, 1, 0, 2, 5, 3]
        print("重复的内容：\(leedCode.findRepeatNumberTwo(&mutableArrar))")
    }


}

