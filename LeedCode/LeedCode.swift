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
    public var val: Any
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Any) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

public class StackNode {
    
    public var value:Int?
    public var next:StackNode?
    
    init(_ value:Int?) {
        self.value = value
        self.next = nil
    }
    
}
/*
 栈遵循 LIFO
 队列遵循 FIFO
 通常固定操作是：
 1.Push 入栈
 2.Pop 出栈
 */
class Stack: NSObject {
    var stack:[Int] = []
    func push(_ element:Int) {
        self.stack.append(element)
    }
    
    func pop() -> Int{
        return self.stack.popLast() ?? -1
    }
    
    func displayElement() {
        var index = self.stack.count - 1
        while index > 0 {
            let indexValue = self.stack.firstIndex(of: index)
            print("\(String(describing: indexValue))")
            index = index - 1
        }
    }
}

//MARK:用两个栈实现一个队列
/*
 用两个栈实现一个队列。队列的声明如下，请实现它的两个函数 appendTail 和 deleteHead
 ，分别完成在队列尾部插入整数和在队列头部删除整数的功能。(若队列中没有元素，deleteHead
 操作返回 -1 )
 
 示例 1：
 输入：
 ["CQueue","appendTail","deleteHead","deleteHead"]
 [[],[3],[],[]]
 输出：[null,null,3,-1]
 
 
 示例 2：
 输入：
 ["CQueue","deleteHead","appendTail","appendTail","deleteHead","deleteHead"]
 [[],[],[5],[2],[],[]]
 输出：[null,-1,null,null,5,2]
 提示：
 1 <= values <= 10000
 最多会对 appendTail、deleteHead 进行 10000 次调用
 */

class CQueue {
    
    var storeStack:[Int] = []
    var tmpStoreStack:[Int] = []

    init() {
        
    }
    
    func appendTail(_ value: Int) {
        self.storeStack.append(value)
    }
    
    func deleteHead() -> Int {
        
        if self.tmpStoreStack.isEmpty {
            while !self.storeStack.isEmpty {
                self.tmpStoreStack.append(self.storeStack.removeLast())
            }
        }
        
        return self.tmpStoreStack.isEmpty ? -1 : self.tmpStoreStack.removeLast()
    }
    
    func displayElement() {
        var index = 0
        while index < self.storeStack.count {
            print("\(self.storeStack[index])")
            index = index + 1
        }
    }
}

class LeedCode: NSObject {
    
    //
    /*使用二分法查找*/
    func minArray(_ numbers: [Int]) -> Int {
        
        var i = 0
        var j = numbers.count - 1
        
        while i < j {
            
            let m = (i + j)/2
            if numbers[m] > numbers[j] {
                i = m + 1
            }
            
            if numbers[m] < numbers[j] {
                j = m
            }
            
            if numbers[m] == numbers[j] {
                j = j - 1
            }
            
        }
        
        return numbers[i]
    }
    
    //MARK:青蛙跳台阶问题
    /*
     一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。

     答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

     示例 1：

     输入：n = 2
     输出：2
     示例 2：

     输入：n = 7
     输出：21
     示例 3：

     输入：n = 0
     输出：1
     提示：

     0 <= n <= 100

     */
    
    //基本解法：使用递归操作，其中使用中间值保存已存在的变量来避免数据的重复运算问题
    //时间复杂度O(2^n)
    func numWays(_ n: Int) -> Int {

        var tmpValue = [Int:Int]()
        if n == 0 || n == 1 {
            return 1
        }
        
        else if n == 2 {
            return 2
        }
        
        else{
            var jumpOneStep = 0
            var jumpTwoStep = 0
            
            if let jumpOneTmpStep = tmpValue[n - 1] {
                jumpOneStep = jumpOneTmpStep
            }else{
                jumpOneStep = self.numWays(n - 1)
                tmpValue[n - 1] = jumpOneStep
            }
            
            if let jumpTwoTmpStep = tmpValue[n - 2] {
                jumpTwoStep = jumpTwoTmpStep
            }else{
                jumpTwoStep = self.numWays(n - 2)
                tmpValue[n - 2] = jumpTwoStep
            }
            
            return jumpOneStep + jumpTwoStep
        }
        
    }
    
    //使用数组遍历，时间复杂度为O(n)
    func numWaysTwo(_ n: Int) -> Int {
        
        guard n <= 100 && n >= 0 else {
            return -1
        }
        
        if n == 0 || n == 1 {
            return 1
        }
        
        if n == 2 {
            return 2
        }
        
        var preWays = 1
        var curWays = 2
        var sumWays = 0
        
        for _ in 3...n {
            sumWays = (preWays + curWays)%1000000007
            preWays = curWays
            curWays = sumWays
        }
        
        return sumWays

    }
    
    //最优方法是采用矩阵方法，此方法是斐波拉契的时间最优解，时间复杂度为O(logn)的
    
    /*
     使用拆分法，又叫分治归并算法
     时间复杂度O(n)
     */
    func powSplit(_ x: Int, _ n: Int) -> Int {
        if n == 0 {
            return 1
        }
        
        if n == 1 {
            return x
        }
        
        //偶数
        if n & 1 == 0 {
            return self.powSplit(x, n/2) * self.powSplit(x, n/2)
        }
        
        //奇数
        return self.powSplit(x, (n-1)/2) * self.powSplit(x, (n-1)/2) * x
    }
    
    //MARK:求解x的n次方的结果
    /*
     分治思想:
     将整个集合划分为不可分割的子集（判定返回的条件）
     然后算出子集的结果，最终返回结果
     可以采用递归，同样也可采取循环迭代的思想
     */
    func pow(_ x: inout Int, _ n: inout Int) -> Int {
        
        if n < 0 {
            x = 1/x
            n = -n
        }
        
        if n == 0 {
            return 1
        }
        if n == 1 {
            return x
        }
        
        //拷贝一份新的可变数值
        var localX = x
        var localN = n/2
        
        let tmpValue = self.pow(&localX, &localN) * self.pow(&localX, &localN)
        //偶数
        if n % 2 == 0 {
            return tmpValue
        }else{
            return tmpValue * x
        }
    
    }
    
    func powByByte(_ x: Int, _ n: Int) -> Int {
        
        if x == 0 {
            return 0
        }
        
        if x == 1 {
            return x
        }
        
        var localN = n
        var localX = x
        var result = 1
        
        while localN != 0 {
            //当前位有效，乘以权值
            if localN & 1 != 0 {
                result  = localX * result
            }
            //移位之前要按位加权
            localX = (localX * localX)
            localN = localN>>1
        }
        
        return result
    }
    
    /*
    
     按位计算:
     
   
    */
    func pow_byte(_ x: Int, _ n: Int) -> Int {
        
        var localX = x
        var localN = n
        if localN < 0 {
            localX = 1/localX
            localN = -localN
        }
        
        if localN == 0 {
            return 1
        }
        
        if localN == 1 {
            return x
        }
        
        var pow = 1
        while localN != 0 {
            if localN & 1 == 1 {
                pow *= localX
            }
            //按权位升级幂底数
            localX = localX * localX
            //向右移位1
            localN = localN >> 1
        }
        
        return pow
    }
    
    
    //MARK：创建栈数据结构
    func creatStack() {
        
        let stack = Stack()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
        stack.push(5)
        print("入栈之后的内容")
        stack.displayElement()
        stack.pop()
        print("出栈之后的内容")
        stack.displayElement()
        
    }
    
    func testUse() {
        print("最终结果是\(self.fib(41))")
    }
    
    //MARK:斐波那契数列
    /*
    写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项。斐波那契数列的定义如下：
    
    F(0) = 0,   F(1) = 1
    F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
    斐波那契数列由 0 和 1 开始，之后的斐波那契数就是由之前的两数相加而得出。
    答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

    示例 1：
    输入：n = 2
    输出：1
    
    示例 2：
    输入：n = 5
    输出：5
    
    提示：
    0 <= n <= 100
    */
    //方案一：最low的方法，普通程序员首选，如果有人这么写，也就大学水平，如果按算法来定义的话，pass掉
    func fib(_ n: Int) -> Int {
        
        guard n >= 0 && n <= 100 else {
            return -1
        }

        if n == 0{
            return 0
        }
        
        if n == 1 {
            return 1
        }
        
        return (self.fib(n - 1) + self.fib(n - 2))%1000000007
    }
    
    //方案二：利用最后两项的想加结果中间数量替换
    func fibTwo(_ n: Int) -> Int {
        var a = 0, b = 1, sum = 0
        for _ in 0..<n {
            sum = (a + b) % 1000000007
            a = b
            b = sum
        }
        
        return a
    }
    
    /*
     测试求值
     */
    func fibTestDemo(_ n: Int) -> Int {
        let res = self.fibMatrix(n)
        return res[0][1]
    }
    
    /*
     使用矩阵乘法升维计算
     */
    func fibMatrix(_ n: Int) -> [[Int]] {
        let MartrixUnit = [[1,1],[1,0]]
        if n == 0 {
            return [[0,0],[0,0]]
        }
        if n == 1{
            return MartrixUnit
        }
        print("矩阵结果:\(self.powMartrix(MartrixUnit, n))")
        return self.powMartrix(MartrixUnit, n)
        
    }
    
    /*
     升幂运算，依据矩阵推倒公式，相关的算法例如求解x的n次幂:x^n
     */
    func powMartrix(_ x: [[Int]], _ n: Int) -> [[Int]] {
        //先变成单位矩阵
        var result = [[1,0],[0,1]]
        var localN = n
        var localX = x
        while localN != 0 {
            if localN & 1 != 0{
                result = self.MartrixMutiply(localX, result)
            }
            localX = self.MartrixMutiply(localX, localX)
            localN = localN >> 1
        }
        
        return result
    }
    
    /*
     矩阵乘法算法
     */
    func MartrixMutiply(_ leftMartrix: [[Int]], _ rightMartrix: [[Int]]) -> [[Int]] {
        var resMartrix = [[Int]]()
        var rowArr = [Int]()
        for row in 0..<leftMartrix.count{
            for col in 0..<rightMartrix[0].count{
                rowArr.append(self.countElementIndex(leftMartrix, row, rightMartrix, col))
            }
            resMartrix.append(rowArr)
            rowArr.removeAll()
        }
        return resMartrix
    }
    
    /*
     计算某行元素与某一列元素的乘积和
     */
    func countElementIndex(_ leftArray: [[Int]], _ rowIndex: Int, _ rightArray: [[Int]], _ colIndex: Int ) -> Int {
        
        //要符合两个矩阵相乘的前提
        guard leftArray.count == rightArray[0].count else {
            return -1
        }
        
        var result = 0
        for index in 0..<leftArray.count {
            result = result + leftArray[rowIndex][index] * rightArray[index][colIndex]
        }
        
        return result
    }

    
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
        
        let treeNode = self.buildTree([3,2,1], [1,2,3])
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
     前序遍历遍历完当前节点之后，先遍历左子树的所有节点之后才会去遍历右子树的节点，假设当前遍历先序数组
     的下标为preOrderIndex,通过中序遍历找到当前的节点在中序遍历的位置，此时当前节点所在的树的节点数就
     是左子树的节点数（等于此时的节点下标值inorderRootIndex），所以能推出当前左子树在前序遍历的边界下标
     （preOrderIndex + inorderRootIndex）,右子树的边界值为当前子树的截止下标 inorderRootIndex
     加上右子树节点数量（end - (preOrderIndex + inorderRootIndex)）
     
     前序遍历与中序遍历公共的特点就是优先遍历左子树的所有节点之后，最后才去遍历右子树的内容（重要）
     
     依据以上两个特点，还原二叉树，可以按照以下的思路进行：
     1.前序遍历的数组的下标进行数据编号
     2.遍历前序遍历的元素，遍历过程中，查找元素在中序遍历中的位置来确定当前元素所在节点左子树节点以及右子数节点数目，
       依据前序遍历数组，再结合左子树的节点数目，确定左子树在前序遍历的边界内容。同理依据
     
     */
    
    func buildChildTree(_ preorder: [Int], _ startIndex:Int, _ endIndex:Int, _ inorder: [Int], _ mapIndexValue: [Int:Int]) -> TreeNode? {
        
        if startIndex > endIndex{
            print("遍历结束")
            return nil
        }
        
        let rootNode = TreeNode.init(preorder[startIndex])
        
        if startIndex == endIndex {
            print("子节点:\(preorder[startIndex])")
            return rootNode
        }
        
        if let rootNodeIndex = inorder.firstIndex(of: preorder[startIndex]){
                        
            print("起始位置:\(startIndex + 1), 终止位置：\(rootNodeIndex)")
            
            //保证所有节点都能遍历到（包括根节点）
            rootNode.left = self.buildChildTree(preorder, startIndex + 1, rootNodeIndex + 1, inorder, mapIndexValue)
            
            rootNode.right = self.buildChildTree(preorder, rootNodeIndex + 1, endIndex, inorder, mapIndexValue)
                        
            return rootNode
        }
        
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
