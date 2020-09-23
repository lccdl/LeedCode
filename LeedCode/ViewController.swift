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
        print("最小的数：\(leedCode.minArray([2,2,2,0,1]))")
        print("正常求解斐波那契数列:\(leedCode.fibTwo(6))")
        print("矩阵求解斐波那契数列:\(leedCode.fibTestDemo(6))")
        
        print("2的10次幂:\(leedCode.powByByte(2, 10))")
    }


}

