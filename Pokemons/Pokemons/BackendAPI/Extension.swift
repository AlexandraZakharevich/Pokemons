//
//  Extension.swift
//  Pokemons
//
//  Created by Александра Захаревич on 17.11.22.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromUrl(_ url: String) {
        DispatchQueue.global().async {
        if let pictureUrl = URL(string: url) {
            if let data = try? Data(contentsOf: pictureUrl) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                    self.image = image
                    }
                }
            }
        }
    }
}
}
