//
//  ViewController.swift
//  FormulariosA
//
//  Created by Gerson Isaias on 28/01/21.
//

import UIKit

class ProductoViewController: UIViewController, UITextFieldDelegate {

    //Outlets
    @IBOutlet weak var tfNombreProd: UITextField!
    @IBOutlet weak var tfModeloProd: UITextField!
    @IBOutlet weak var tfCantidadProd: UITextField!
    @IBOutlet weak var tfPrecioProd: UITextField!
    @IBOutlet weak var swDisponibilidad: UISwitch!
    @IBOutlet weak var btnGuardar: UIButton!
    
    @IBOutlet var textfieldArray: [UITextField]!
    //Stored properties
    let defaults = UserDefaults.standard
    var products:[Producto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = textfieldArray.map({ $0.delegate = self })
        //round
        self.btnGuardar.layer.cornerRadius = self.btnGuardar.bounds.height / 2
    }

    @IBAction func guardarProducto(_ sender: Any) {
        
        let nombre:String = tfNombreProd.text ?? ""
        let modelo:String = tfModeloProd.text ?? ""
        let cantidad:Int = Int(tfCantidadProd.text ?? "0") ?? 0
        let precio:Double = Double(tfPrecioProd.text ?? "0.0") ?? 0.00
        let disponibilidad = swDisponibilidad.isOn
        
        if !nombre.isEmpty && !modelo.isEmpty {
            let producto = Producto(nombre: nombre, modelo: modelo, cantidad: cantidad, precio: precio, disponibilidad: disponibilidad)
            producto.store(vc: self)
            
        }else{
            self.alertDefault(with: "Faltan campos", andWithMsg: "Necesitas llenar los campos correctamente")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y -= 15
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y += 15
        }
    }
    
    
    @IBAction func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}

extension UIViewController {
    func alertDefault(with title:String, andWithMsg description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (a) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

