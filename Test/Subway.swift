//
//  Subway.swift
//  Test
//
//  Created by 정수범 on 2020/11/20.
//

import Foundation

struct SubwayResult: Decodable {
    var result: [SubwayDetail]
}

struct SubwayDetail: Decodable {
    var name: String
    var type: TypeInfo
}

struct TypeInfo: Decodable {
    var types: String
}
