//
//  ViewController.swift
//  audiogid2
//
//  Created by  admin on 01.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func websiteBtn(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "http://nabokov.museums.spbu.ru")!)
    }


}

