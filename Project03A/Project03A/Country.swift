//
//  Country.swift
//  Project03A
//
//  Created by Erik Radicheski da Silva on 30/05/22.
//

import Foundation

struct Country {
    let name: String
    let alphaTwo: String
    let alphaThree: String
    let numeric: String
}

extension Country: Codable {}

extension Country: Hashable {}
