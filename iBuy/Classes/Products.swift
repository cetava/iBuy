//
//  Products.swift
//  iBuy
//
//  Created by Cesar A. Tavares on 04/11/20.
//

import Foundation

class Products {
    
    var name: String
    var completed: Bool
    
    init(name: String, completed: Bool) {
        self.name = name
        self.completed = completed
    }
}

extension Products: SearchProtocol {
    func getProduct() -> String {
        return "\(name)".folding(options: .diacriticInsensitive, locale: .current).lowercased()
    }
}
