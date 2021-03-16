//
//  链表存储的两数相加.swift
//  LeedCode
//
//  Created by 李臣臣 on 2021/3/16.
//  Copyright © 2021 李臣臣. All rights reserved.
//

import Foundation


/*
 
 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。
 请你将两个数相加，并以相同形式返回一个表示和的链表。
 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。


 输入：l1 = [2,4,3], l2 = [5,6,4]
 输出：[7,0,8]
 解释：342 + 465 = 807.
 示例 2：

 输入：l1 = [0], l2 = [0]
 输出：[0]
 示例 3：

 输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 输出：[8,9,9,9,0,0,0,1]
  

 提示：

 每个链表中的节点数在范围 [1, 100] 内
 0 <= Node.val <= 9
 题目数据保证列表表示的数字不含前导零

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }

}

class Solution {
    
    func printNode(_ node: inout ListNode?) {
        while node != nil {
            print("--\(String(describing: node?.val))--")
            node = node?.next
        }
    }
    
    func getL1() -> ListNode? {
        let node3 = ListNode(3, nil)
        let node2 = ListNode(4, node3)
        let node1 = ListNode(2, node2)
        return node1
    }
    
    func getL2() -> ListNode? {
        let node3 = ListNode(4, nil)
        let node2 = ListNode(6, node3)
        let node1 = ListNode(5, node2)
        return node1
    }
    
    func getL3() -> ListNode? {
        let node7 = ListNode(9, nil)
        let node6 = ListNode(9, node7)
        let node5 = ListNode(9, node6)
        let node4 = ListNode(9, node5)
        let node3 = ListNode(9, node4)
        let node2 = ListNode(9, node3)
        let node1 = ListNode(9, node2)
        return node1
    }
    
    func getL4() -> ListNode? {
        let node4 = ListNode(9, nil)
        let node3 = ListNode(9, node4)
        let node2 = ListNode(9, node3)
        let node1 = ListNode(9, node2)
        return node1
    }
    
    func test3() {
        var head = addTwoNumbers(getL3(), getL4());
        printNode(&head)
    }
    
    
    func test1() {
        let l1 = getL1()
        let l2 = getL2()
        var head = addTwoNumbers(l1, l2);
        printNode(&head)
    }
    
    func test2() {
        let node1 = ListNode(0)
        let node2 = ListNode(0)
        var head = addTwoNumbers(node1, node2)
        printNode(&head)
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        if l1 == nil || l2 == nil {
            return nil
        }
        
        var l1Length = 1
        var l2Length = 1
        var l1NextNode = l1
        var l2NextNode = l2
        
        while l1NextNode?.next != nil {
            l1Length += 1
            l1NextNode = l1NextNode?.next
        }
        
        while l2NextNode?.next != nil {
            l2Length += 1
            l2NextNode = l2NextNode?.next
        }
        
        if l1Length > l2Length {

            let delCount = l1Length - l2Length
            for _ in 0..<delCount {
                let node = ListNode(0, nil)
                l2NextNode?.next = node
                l2NextNode = node
            }
            
        }else if l1Length < l2Length {
            let delCount = l2Length - l1Length
            for _ in 0..<delCount {
                let node = ListNode(0, nil)
                l1NextNode?.next = node
                l1NextNode = node
            }
        }
        
        //进行相加
        l1NextNode = l1
        l2NextNode = l2
        var countFlag = 0
        
        var headNode: ListNode? = nil
        var lastNode: ListNode? = headNode
        
        while l1NextNode != nil {
            var count = countFlag + l1NextNode!.val + l2NextNode!.val
            countFlag = count >= 10 ? 1 : 0
            count = count % 10
            
            let node = ListNode(count, nil)
            if headNode == nil {
                headNode = node
            }
            lastNode?.next = node
            lastNode = node
            l1NextNode = l1NextNode?.next
            l2NextNode = l2NextNode?.next
        }
        
        //最后一位如果是进位需要向上加一
        if countFlag == 1 {
            let node = ListNode(1, nil)
            lastNode?.next = node
            lastNode = node
        }

        return headNode
    }
}
