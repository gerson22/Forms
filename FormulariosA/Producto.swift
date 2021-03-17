//
//  Producto.swift
//  FormulariosA
//
//  Created by Gerson Isaias on 28/01/21.
//

import UIKit

class Producto: Codable {
    var nombre:String
    var modelo:String
    var cantidad: Int
    var precio: Double
    var disponibilidad: Bool
    
    
    init(nombre:String, modelo:String, cantidad:Int, precio:Double, disponibilidad:Bool) {
        self.nombre = nombre
        self.modelo = modelo
        self.cantidad = cantidad
        self.precio = precio
        self.disponibilidad = disponibilidad
    }
    
    func store(vc:UIViewController){
        App.shared.products = self.getProducts()
        App.shared.products.append(self)
        print("Productos: \(App.shared.products)")
        
        do{
            let encode = JSONEncoder()
            let data = try encode.encode(App.shared.products) //58bytes
            App.shared.defaults.setValue(data, forKey: "productos")
            
            vc.alertDefault(with: "Producto guardado", andWithMsg: "El producto ha sido almacenado con exito")
        }catch{
            print("La decodificacion no fue posible")
        }
    }
    
    func getProducts() -> [Producto]{
        if let data =    App.shared.defaults.object(forKey: "productos") as? Data {
            let decoder = JSONDecoder()
            guard let productos = try? decoder.decode([Producto].self, from: data) else {
                fatalError("No se ha logrado hacer el parceo")
            }
            
            return productos
        }
        return [Producto]()
    }
}
