//
//  EmptyModel.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 18/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation

func createEmptyVideoMatrix(length: Int) -> [[Video]]{
    return [[Video]](count: length, repeatedValue: [])}

func createEmptyStringArray(length: Int) -> [String]{
    return [String](count: length, repeatedValue: "")
}

func createEmptyBoolArray(length: Int) -> [Bool]{
    return [Bool](count: length, repeatedValue: false)
}

func createEmptyStringMatrix(length: Int) -> [[String]]{
    return [[String]](count: length, repeatedValue: [])}
