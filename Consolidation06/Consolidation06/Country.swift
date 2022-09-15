//
//  Country.swift
//  Consolidation06
//
//  Created by Erik Radicheski da Silva on 15/09/22.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String?
    let area: Double?
    let population: Int
    let currencies: [Currency]?
}
