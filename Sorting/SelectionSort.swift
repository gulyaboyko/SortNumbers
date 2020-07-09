//
//  SelectionSort.swift
//  Sorting
//
//  Created by Gulya Boiko on 6/30/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation
import AlgoTester

// Принцып: Массив делится на 2 части: отсортированную и неотсортированную
// находим наименьший элемент и меняется местами с первым неотсортированным
struct SelectionSort {
    func sort(_ array: inout [Int]) {
        guard array.count > 0 else { return }
        func findMin(from: Int) -> Int {
            var min = from
            for i in from+1..<array.count {
                if array[min] > array[i] {
                    min = i
                }
            }
            return min
        }
        func swap(from: Int, to: Int) {
            let x = array[from]
            array[from] = array[to]
            array[to] = x
        }
        for i in (0...array.count - 1) {
            let indexMin = findMin(from: i)
            swap(from: indexMin, to: i)
        }
    }
}

extension SelectionSort: Testable {
    func run(data: [String]) -> String {
        guard Int(data[0])! <= 10000 else { return "" }
        var array = data[2].components(separatedBy: " ").compactMap { Int($0) }
        let startDate = Date()
        sort(&array)
        print("Selection sort: \(data[0]) - \(startDate.distance(to: Date()) * 1000)")
        return (array.map { String($0) }).joined(separator: " ")
    }
}
