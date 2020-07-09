//
//  InsertionSort.swift
//  Sorting
//
//  Created by Gulya Boiko on 6/30/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation
import AlgoTester

// Принцып: перебираются элементы в неотсортированной части массива и по одному вставляются в отсортированную часть массива на то место где он должен находиться
struct InsertionSort {
    func classicSort(_ array: inout [Int]) {
        guard array.count > 0 else { return }
        func swap(from: Int, to: Int) {
            let x = array[from]
            array[from] = array[to]
            array[to] = x
        }
        for i in 1..<array.count {
            let range = stride(from: i-1, through: 0, by:-1)
            for j in range {
                guard array[j] > array[j+1] else { break }
                swap(from: j+1, to: j)
            }
        }
    }
    func halfDivisionSort(_ array: inout [Int]) {
        guard array.count > 0 else { return }
        // найти место в отсортированной части массива для вставки
        func findPlaceToInsert(index: Int) -> Int {
            // index - индекс нового элемента
            // [0..index-1] - уже отсортированный массив
            let value = array[index]
            var fromIndex = 0
            var toIndex = index - 1
            var center: Int = (fromIndex + toIndex)/2
            while center != fromIndex {
                if array[center] > value { toIndex = center }
                if array[center] <= value { fromIndex = center }
                center = (fromIndex + toIndex)/2
            }
            if array[fromIndex] > value { return fromIndex }
            if array[toIndex] > value { return toIndex }
            return index
        }
        // вставить новый элемент в нужное место
        func insert(from: Int, to: Int) {
            guard from != to else { return }
            let value = array[from] // запомнили новый элемент
            let range = stride(from: from, through: to+1, by:-1)
            for i in range {
                array[i] = array[i-1] // двигаем элементы вправо
            }
            array[to] = value // вставили новый элемент
        }
        for i in 1..<array.count {
            let indexInSortedArray = findPlaceToInsert(index: i)
            insert(from: i, to: indexInSortedArray)
        }
    }
}

extension InsertionSort: Testable {
    func run(data: [String]) -> String {
        guard Int(data[0])! <= 100_000 else { return "" }
        var array = data[2].components(separatedBy: " ").compactMap { Int($0) }
        let startDate = Date()
        halfDivisionSort(&array)
        print("Insertion sort: \(data[0]) - \(startDate.distance(to: Date()) * 1000)")
        return (array.map { String($0) }).joined(separator: " ")
    }
}
