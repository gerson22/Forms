//
//  App.swift
//  FormulariosA
//
//  Created by Gerson Isaias on 28/01/21.
//

import UIKit

class App: NSObject {
    static var shared = App()
    var products:[Producto] = []
    var defaults = UserDefaults.standard
}
