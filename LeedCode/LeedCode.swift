//
//  LeedCode.swift
//  LeedCode
//
//  Created by 李臣臣 on 2020/9/1.
//  Copyright © 2020 李臣臣. All rights reserved.
//

import UIKit


// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


class LeedCode: NSObject {
    
    //MARK:重建二叉树，新手来说比较复杂
    /*
     输入某二叉树的前序遍历和中序遍历的结果，请重建该二叉树。
     假设输入的前序遍历和中序遍历的结果中都不含重复的数字。

     例如，给出
     前序遍历 preorder = [3,9,20,15,7]
     中序遍历 inorder = [9,3,15,20,7]
     返回如下的二叉树：

         3
        / \
       9  20
         /  \
        15   7
      
     限制：
     0 <= 节点个数 <= 5000

     */
    
    func testBuildTree() {
        
        let treeNode = self.buildTree([1,2,3], [3,2,1])
        print("前序遍历")
        self.traverseLead(treeNode)
        
        print("中序遍历")
        self.traverseMiddle(treeNode)
        
        print("后序遍历")
        self.traverseEnd(treeNode)
    }
    
    func creatTree() -> TreeNode? {
        //创建二叉树
        let rootNode = TreeNode.init(3)
        let leftOneRoot = TreeNode.init(9)
        let rightOneRoot = TreeNode.init(20)
        let rightOneLeftNode = TreeNode.init(15)
        let rightOneRightNode = TreeNode.init(7)
        
        rootNode.left = leftOneRoot
        rootNode.right = rightOneRoot
        rightOneRoot.left = rightOneLeftNode
        rightOneRoot.right = rightOneRightNode
        
        return rootNode
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count > 5000 || preorder.count < 0{return nil}
        
        var preorderIndexMap = [Int:Int]()
        for index in 0..<preorder.count {
            preorderIndexMap[index] = preorder[index]
        }

        return self.buildChildTree(preorder, 0, preorder.count - 1, inorder, preorderIndexMap)
    }
    
    /*
     思路：
     解题之前需要了解一下前序遍历、中序遍历的特点
     前序遍历的特点是优先遍历节点，再去遍历节点下面的叶子节点（叶子节点也含有子节点的话，循环遍历）
     中序遍历的特点是先遍历节点的左边叶子节点，再遍历节点，最后遍历右节点
     
     注意：
     前序遍历遍历完当前节点之后，先遍历左子树的所有节点之后才会去遍历右子树的节点，这个特点很重要
     通过中序遍历找到当前的节点在中序遍历的位置，那么中序遍历下标左边的所有节点数目就是当前节点的左子树数量总和
     同理，右边节点数目也能确定
     
     前序遍历与中序遍历公共的特点就是优先遍历左子树的所有节点之后，最后才去遍历右子树的内容（重要）
     
     依据以上两个特点，还原二叉树，可以按照以下的思路进行：
     1.前序遍历的数组的下标进行数据编号
     2.遍历前序遍历的元素，遍历过程中，查找元素在中序遍历中的位置来确定当前元素所在节点左子树节点以及右子数节点
       如果
     
     */
    
    func buildChildTree(_ preorder: [Int], _ startIndex:Int, _ endIndex:Int, _ inorder: [Int], _ mapIndexValue: [Int:Int]) -> TreeNode? {
        
        if startIndex > endIndex{
            return nil
        }
        
        let rootNode = TreeNode.init(preorder[startIndex])
        
        //找到节点所在的下标
        if let leftTreeEndIndex = inorder.firstIndex(of: preorder[startIndex]){
            
            print("--------endIndex:\(endIndex) startInd:\(startIndex)")
            //判断右子树节点个数与左子树节点个数，确定是否含有左子树或者是右子树
            //已经遍历过的节点数目
            let leftTreeNode = self.buildChildTree(preorder, startIndex + 1, leftTreeEndIndex, inorder, mapIndexValue)
            rootNode.left = leftTreeNode
            
            //                if endIndex - leftTreeEndIndex > 0 {
            //                    let rightTreeNode = self.buildChildTree(preorder, leftTreeEndIndex + 1, endIndex, inorder, mapIndexValue)
            //                    rootNode.right = rightTreeNode
            //                }
            
            return rootNode
        }
        
        
        
//
//        if startIndex == endIndex {
//            return rootNode
//        }else{
//
//            //找到节点所在的下标
//            if let leftTreeEndIndex = inorder.firstIndex(of: preorder[startIndex]){
//
//                print("--------endIndex:\(endIndex) startInd:\(startIndex)")
//                //判断右子树节点个数与左子树节点个数，确定是否含有左子树或者是右子树
//                //已经遍历过的节点数目
//                let leftTreeNode = self.buildChildTree(preorder, startIndex + 1, leftTreeEndIndex, inorder, mapIndexValue)
//                rootNode.left = leftTreeNode
//
////                if endIndex - leftTreeEndIndex > 0 {
////                    let rightTreeNode = self.buildChildTree(preorder, leftTreeEndIndex + 1, endIndex, inorder, mapIndexValue)
////                    rootNode.right = rightTreeNode
////                }
//
//                return rootNode
//            }
//
//
//        }
        
        return rootNode;
    }
    
    //二叉树的遍历，前序遍历
    func traverseLead(_ treeNode:TreeNode?) -> Void {
        
        guard treeNode != nil else {
            return
        }
        
        print("\(treeNode?.val),")
        self.traverseLead(treeNode?.left)
        self.traverseLead(treeNode?.right)
    }
    
    //中序遍历
    func traverseMiddle(_ treeNode:TreeNode?) ->  Void{
        guard treeNode != nil else {
            return
        }
        
        self.traverseMiddle(treeNode?.left)
        print("\(treeNode?.val)")
        self.traverseMiddle(treeNode?.right)
        
    }
    
    //后序遍历
    func traverseEnd(_ treeNode:TreeNode?) -> Void {
        guard treeNode != nil else {
            return
        }
        
        self.traverseEnd(treeNode?.left)
        self.traverseEnd(treeNode?.right)
        print("\(treeNode?.val), ")
        
    }
    
    //MARK:从尾到头打印链表
    /*
     输入一个链表的头节点，从尾到头反过来返回每个节点的值（用数组返回）。
     
     示例 1：
     输入：head = [1,3,2]
     输出：[2,3,1]
      
     限制：
     0 <= 链表长度 <= 10000
     
     */
    func reversePrint(_ head: ListNode?) -> [Int] {
        
        var currentNode = head
        var nextNode = currentNode?.next
        var reversedArr:[Int] = []
        while currentNode != nil {
            if let value = currentNode?.val {
                reversedArr.append(value)
            }
            currentNode = nextNode
            nextNode = currentNode?.next
        }
       return reversedArr.reversed()
    }
    
    func reversePrintRecursion(_ head: ListNode?) -> [Int] {
        
        if head?.next != nil {
            
            var returnArrar = self.reversePrint(head?.next)
            if let curValue = head?.val {
                returnArrar.append(curValue)
            }
             return returnArrar
        }else{
            var listArr:[Int] = []
            if let curValue = head?.val {
                listArr.append(curValue)
            }
            
            return listArr
        }
       
    }


    //MARK:找出数组中重复的数字
    /*
     在一个长度为n的数组nums里的所有数字都在0～n-1的范围内。
     数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。
     请找出数组中任意一个重复的数字。
     */
    
    //解法一：时间与空间复杂度均为O(n)
    func findRepeatNumber(_ nums: [Int]) -> Int {
        
        let leetDict = NSMutableDictionary()
        for index in 0..<nums.count{
            if leetDict.object(forKey: NSNumber(value: nums[index])) != nil {
                return nums[index]
            }
            leetDict.setObject(1, forKey: NSNumber(value: nums[index]))
        }
        
        return -1
    }
    
    //解法二:原地哈希 空间复杂度：O(1) 时间复杂度:O(n)
    func findRepeatNumberTwo(_ numsSource: [Int]) -> Int {
        
        var nums = NSMutableArray(array: numsSource) as! [Int]
        
        for index in 0..<nums.count {
            
            while nums[index] != index{
                if nums[index] == nums[nums[index]] {
                    return nums[index]
                }
                
                nums.swapAt(index, nums[index])
            }
        }
        
        return -1
    }
    
    /*
     解法三：先排序，找临近相同则立即返回
     */
    
    func findRepeatNumberThree(_ nums: [Int]) -> Int {
        let sortArray = nums.sorted()
        var preValue = sortArray[0]
        for index in 1..<sortArray.count{
            if sortArray[index] == preValue {
                return preValue
            }
            preValue = sortArray[index]
        }
        
        
        return -1;
    }
    
    //MARK: 二维数组中的查找
    /*
     在一个 n * m 的二维数组中，每一行都按照从左到右递增的顺序排序，
     每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，
     判断数组中是否含有该整数。

    示例:

    现有矩阵 matrix 如下：

    [
      [1,   4,  7, 11, 15],
      [2,   5,  8, 12, 19],
      [3,   6,  9, 16, 22],
      [10, 13, 14, 17, 24],
      [18, 21, 23, 26, 30]
    ]

     给定 target = 5，返回 true。
     给定 target = 20，返回 false。
     
     限制：
     0 <= n <= 1000
     0 <= m <= 1000
     
     时间复杂度：
     控件复杂度:
     */
    
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        
        guard matrix.count != 0 && matrix[0].count != 0 else {
            return false
        }

        var cloumCount = matrix[0].count
        
        for row in 0..<matrix.count {
            for cloumIndex in 0..<cloumCount{
                if target == matrix[row][cloumIndex] {return true}
                if target <  matrix[row][cloumIndex]{
                    cloumCount = cloumIndex
                    break
                }
            }
        }
        
        return false
    }
    
    //MARK:替换空格
    /*
     请实现一个函数，把字符串 s 中的每个空格替换成"%20"。
     
     示例 1：
     输入：s = "We are happy."
     输出："We%20are%20happy."
     
     限制：
     0 <= s 的长度 <= 10000
     
     注意如果输入的是两个空格的时候会有异常情况
     */
    func replaceSpace(_ s: String) -> String {
        guard s.count >= 0 && s.count <= 10000 else {
            return ""
        }
        var resultStr = ""
        for index in 0..<s.count {
            let indexRange = s.index(s.startIndex, offsetBy: index)
            let word = s[indexRange]
            if word == " " {
                resultStr.append("%20")
            }else{
                resultStr.append(word)
            }
        }
        
        return resultStr
    }
    
    //系统有指定的方法
    func replaceSpaceSystemMethod(_ s: String) -> String {
        guard s.count >= 0 && s.count <= 10000 else {
            return ""
        }
        return s.replacingOccurrences(of: " ", with: "%20")
    }
    
    
}
