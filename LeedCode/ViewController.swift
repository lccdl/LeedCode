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
        
//        let leedCode = LeedCode()
//        leedCode.creatStack()
        
        let obj = CQueue()
        obj.appendTail(1)
        obj.appendTail(2)
        obj.appendTail(3)
        obj.appendTail(4)
        obj.appendTail(5)
        print("添加节点前")
        obj.queueStack?.displayStack()
        print("删除的节点\(obj.deleteHead())，删除后：")
        obj.queueStack?.displayStack()
    }


}

