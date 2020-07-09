//
//  SortingTests.swift
//  SortingTests
//
//  Created by Gulya Boiko on 6/30/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import XCTest
@testable import Sorting
import AlgoTester

final class SortingTests: XCTestCase {

    func test() {
        let tester = Tester(task: SelectionSort(), bundleID: "com.gulya.boiko.Sorting")
        tester.runTests()
    }
    
    func test_SelectionSort() {
        let sut = SelectionSort()
        var array = [7, 0, 6, 1, 3, 2, 8, 5, 4, 9]
        sut.sort(&array)
        print(array)
        XCTAssert(array == array.sorted())
    }
    
    func test_shellsort() {
        var array = [7, 0, 6, 1, 3, 2, 8, 5, 4, 9]
        for i in [5, 2, 1] {
            sort(&array, gap: i)
        }
        print(array)
        XCTAssert(array == array.sorted())
    }
    
    private func sort(_ array: inout [Int], gap: Int) {
        guard array.count > 0 else { return }
        for i in 0..<gap {
            // 0, 3, 6 for gap = 3
            let indexesForGap = Array(stride(from: i, to: array.count, by: gap))
            for (index, gapIndex1) in indexesForGap.enumerated() {
                let current = array[gapIndex1]
                for gapIndex2 in indexesForGap[0..<index].reversed() {
                    guard array[gapIndex2] > current else { break }
                    array[gapIndex2 + gap] = array[gapIndex2]
                    array[gapIndex2] = current
                }
            }
        }
    }
    
    
    
    private func sort1(_ array: inout [Int], gap: Int, indexesForGap: [Int] ) {
        guard array.count > 0 else { return }
//        var indexesForGap = Array(stride(from: 0, to: array.count, by: gap))
        
        // найти место в отсортированной части массива для вставки
        func findPlaceToInsert(index: Int) -> Int {
            var arrayIndex = index
            let lastIndex = indexesForGap.firstIndex(of: index) ?? 0
            let range = (indexesForGap[0..<lastIndex]).reversed()
            for i in range {
                if array[i] > array[index] {
                    arrayIndex = i
                }
            }
            return arrayIndex
        }
        // вставить новый элемент в нужное место
        func insert(from: Int, to: Int) {
            guard from != to, let firstIndex = indexesForGap.firstIndex(of: to), let lastIndex = indexesForGap.firstIndex(of: from) else { return }
            let value = array[from] // запомнили новый элемент
            let range = (indexesForGap[firstIndex+1...lastIndex]).reversed()
            for i in range {
                array[i] = array[i-gap] // двигаем элементы вправо
            }
            array[to] = value // вставили новый элемент
        }
        for index in indexesForGap {
            let indexInSortedArray = findPlaceToInsert(index: index)
            insert(from: index, to: indexInSortedArray)
        }
    }
    
//    private func sort2(_ array: inout [Int], gap: Int) {
//        guard array.count > 0 else { return }
//        var indexesForGap = Array(stride(from: 0, to: array.count, by: gap))
//        var arrayToSort = array[stride(from: 0, to: array.count, by: gap)]
//        // найти место в отсортированной части массива для вставки
//        func findPlaceToInsert(index: Int) -> Int {
//            // index - индекс нового элемента
//            // [0..index-1] - уже отсортированный массив
//            let value = arrayToSort[index]
//            var fromIndex = 0
//            var toIndex = index - 1
//            var center: Int = (fromIndex + toIndex)/2
//            while center != fromIndex {
//                if arrayToSort[center] > value { toIndex = center }
//                if arrayToSort[center] <= value { fromIndex = center }
//                center = (fromIndex + toIndex)/2
//            }
//            if arrayToSort[fromIndex] > value { return fromIndex }
//            if arrayToSort[toIndex] > value { return toIndex }
//            return index
//        }
//        // вставить новый элемент в нужное место
//        func insert(from: Int, to: Int) {
//            guard from != to else { return }
//            let value = arrayToSort[from] // запомнили новый элемент
//            for i in (to+1...from).reversed() {
//                arrayToSort[i] = arrayToSort[i-1] // двигаем элементы вправо
//            }
//            arrayToSort[to] = value // вставили новый элемент
//        }
//        for i in 1..<arrayToSort.count {
//            let indexInSortedArray = findPlaceToInsert(index: i)
//            insert(from: i, to: indexInSortedArray)
//        }
//        indexesForGap.enumerated().forEach { (arg) in
//            let (index, gapIndex) = arg
//            array[gapIndex] = arrayToSort
//        }
//    }
    
    func test_pow() {
        XCTAssert(pow(2, 0) == 1)
        XCTAssert(pow(2, 1) == 2)
        XCTAssert(pow(2, 3) == 8)
    }
    
}
