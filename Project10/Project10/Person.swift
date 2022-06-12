//
//  Person.swift
//  Project10
//
//  Created by Erik Radicheski da Silva on 12/06/22.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
