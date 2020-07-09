//
//  HeapSort.swift
//  Sorting
//
//  Created by Gulya Boiko on 6/30/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation
import AlgoTester

struct HeapSort {
    func sort(_ array: inout [Int]) {
        guard array.count > 1 else { return }
        func down(root: Int, size: Int) {
            // size - размер массива
            // root - куда поместить найденный максимальный элемент
            let l = 2*root + 1
            let r = l + 1
            var x = root // max(x, r, l)
            if l < size && array[x] < array[l] { x = l }
            if r < size && array[x] < array[r] { x = r }
            guard x != root else { return }
            swap(from: x, to: root)
            down(root: x, size: size)
        }
        func swap(from: Int, to: Int) {
            let x = array[from]
            array[from] = array[to]
            array[to] = x
        }
        // Формируем кучу из входных данных
        // куча - корень больше его листьев
        for i in (0...(array.count/2 - 1)).reversed() {
            down(root: i, size: array.count)
        }
        
        // имеем кучу
        // 1) макс в конец меняем местами с 0 элементом
        // 2) на size-1 опять создаем кучу - вверх макс элемент вытягиваем
        for i in (1...array.count - 1).reversed() {
            swap(from: 0, to: i) // максимальный в самый последний
            down(root: 0, size: i)
        }
    }
}

extension HeapSort: Testable {
    func run(data: [String]) -> String {
        var array = data[2].components(separatedBy: " ").compactMap { Int($0) }
        let startDate = Date()
        sort(&array)
        print("Heap sort: \(data[0]) - \(startDate.distance(to: Date()) * 1000)")
        return (array.map { String($0) }).joined(separator: " ")
    }
}
