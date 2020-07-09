//
//  ShellSort.swift
//  Sorting
//
//  Created by Gulya Boiko on 7/1/20.
//  Copyright © 2020 com.gulya.boiko. All rights reserved.
//

import Foundation
import AlgoTester

struct ShellSort {
    enum Gaps {
        case Shell
        case Hibbard
        case Sedgewick
    }
    private let gapsType: Gaps
    
    init(gapsType: Gaps) {
        self.gapsType = gapsType
    }
        
    func sort(_ array: inout [Int], gaps: [Int]) {
        guard array.count > 0 else { return }
        for i in gaps {
            sort(&array, gap: i)
        }
    }
    
    private func sort(_ array: inout [Int], gap: Int) {
        guard array.count > 0 else { return }
        for i in 0..<gap {
            let indexesForGap = Array(stride(from: i, to: array.count, by: gap))
            // gapIndex1 = 0, 3, 6, 9 ... for gap = 3
            for gapIndex1 in indexesForGap {
                let currentValue = array[gapIndex1]
                let range = stride(from: gapIndex1-gap, through: 0, by:-gap)
                for gapIndex2 in range {
                    guard array[gapIndex2] > currentValue else { break }
                    array[gapIndex2 + gap] = array[gapIndex2]
                    array[gapIndex2] = currentValue
                }
            }
        }
    }
    
    // Sedgewick 4^k+3*2^(k-1)+1, prefixed with 1
    private func getSedgewickGaps(for count: Int) -> [Int] {
        var result: [Int] = [1]
        for k in 1..<count {
            result.append((pow(4, k) as NSDecimalNumber).intValue + 3*(pow(2, k-1) as NSDecimalNumber).intValue + 1)
            if result.last.unsafelyUnwrapped >= count/2 { break }
        }
        return result.reversed()
    }
    // Shell N/2^k
    private func getShellGaps(for count: Int) -> [Int] {
        var result: [Int] = []
        for k in 1..<count {
            result.append(count/(pow(2, k) as NSDecimalNumber).intValue)
            if result.last == 1 { break }
        }
        return result
    }
    
    // Hibbard 2^k - 1
    private func getHibbardGaps(for count: Int) -> [Int] {
        var result: [Int] = []
        for k in 1..<count {
            result.append((pow(2, k) as NSDecimalNumber).intValue-1)
            if result.last.unsafelyUnwrapped >= count/2 { break }
        }
        return result.reversed()
    }
    
}

extension ShellSort: Testable {
    func run(data: [String]) -> String {
        guard Int(data[0])! <= 1_000_000 else { return "" }
        var gaps: [Int]
        var array = data[2].components(separatedBy: " ").compactMap { Int($0) }
        switch gapsType {
        case .Shell: gaps = getShellGaps(for: array.count)
        case .Hibbard: gaps = getHibbardGaps(for: array.count)
        case .Sedgewick: gaps = getSedgewickGaps(for: array.count)
        }
        let startDate = Date()
        sort(&array, gaps: gaps)
        print("Shell sort: \(data[0]) - \(startDate.distance(to: Date()) * 1000)")
        return (array.map { String($0) }).joined(separator: " ")
    }
}
