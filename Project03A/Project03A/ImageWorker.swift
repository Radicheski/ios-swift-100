//
//  ImageWorker.swift
//  Project03A
//
//  Created by Erik Radicheski da Silva on 30/05/22.
//

import Foundation
import UIKit

enum ImageWorker {

    case shared

    private static var images = [Country: Data]()

    var baseUrl: String { "https://countryflagsapi.com/png/" }

    func loadImage(for country: Country, scale: CGFloat = 1.0, onCompletion: @escaping (UIImage?) -> Void) {

        loadData(for: country) { data in

            if let data = data {
                let image = UIImage(data: data, scale: scale)
                onCompletion(image)
            }
        }
    }

    private func loadData(for country: Country, onCompletion: @escaping (Data?) -> Void) {
        if let data = Self.images[country] {
            onCompletion(data)
            return
        }

        let session = URLSession.shared

        if let url = URL(string: "\(baseUrl)\(country.numeric)") {

            let task = session.dataTask(with: url) { data, _, _ in
                Self.images[country] = data
                onCompletion(data)
            }

            task.resume()
        }
    }

    func clearCache() {
        Self.images.removeAll()
    }

}
