//
//  FullTextViewController.swift
//  Музей Набокова
//
//  Created by Егор Красильников on 10/02/2020.
//  Copyright © 2020  admin. All rights reserved.
//

import UIKit

class FullTextViewController: UIViewController {

    var curAudioItem: AudioItem?
    var number: String = String()
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curAudioItem = Constants.audios[Int(number)!-1]
        textField.text = curAudioItem?.getText()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
