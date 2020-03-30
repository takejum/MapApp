//
//  SecondViewController.swift
//  MapApp
//
//  Created by Jumpei Takeshita on 2020/03/26.
//  Copyright © 2020 Jumpei Takeshita. All rights reserved.
//

import UIKit

protocol searchLocationDelegate {
    func searchLocation(longValue:String, latValue:String)
}

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var latTextField: UITextField!
    
    var delegate:searchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longTextField.delegate = self
        latTextField.delegate = self

    }
    
    @IBAction func okButton(_ sender: Any) {
        let longValue = longTextField.text!
        let latValue = latTextField.text!
        
        if longTextField.text != nil && latTextField.text != nil {
            delegate?.searchLocation(longValue: longValue, latValue: latValue)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        longTextField.endEditing(true)
        latTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        longTextField.resignFirstResponder()
        latTextField.resignFirstResponder()
        return true
    }



}
