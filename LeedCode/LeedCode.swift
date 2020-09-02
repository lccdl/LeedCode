//
//  LeedCode.swift
//  LeedCode
//
//  Created by 李臣臣 on 2020/9/1.
//  Copyright © 2020 李臣臣. All rights reserved.
//

import UIKit

class LeedCode: NSObject {


    //MARK:题目一：找出数组中重复的数字
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
     */
    
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {

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
    
}
