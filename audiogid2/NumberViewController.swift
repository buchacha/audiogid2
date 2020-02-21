//
//  NumberViewController.swift
//  audiogid2
//
//  Created by  admin on 02.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {

    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    
//    Функция для начального состояния
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = String(Constants.audios.count)
    }
    
//    Подготовка перехода к другому окну
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! AudioItemViewController
        destController.number = editText.text!
    }
    
//    Кнопка подтверждения выбранного стенда
    @IBAction func enterBtn(_ sender: Any) {
        let curNumber = editText.text!
        let number = Int(curNumber)
        
        if number != nil {
            if editText.text != "" && number! > 0 && number! < Constants.audios.count + 1 {
                performSegue(withIdentifier: "segue_number", sender: self)
            }
        }
    }
}
