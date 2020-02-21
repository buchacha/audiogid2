//
//  AudioItem.swift
//  audiogid2
//
//  Created by  admin on 02.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit

class AudioItem: NSObject {
    
    var imagePath: String!
    var label: String!
    var audioPath: String!
    var text: String!
    
    init(_ imagePath: String, _ label: String, _ audioPath: String, _ text: String) {
        self.imagePath = imagePath
        self.label = label
        self.audioPath = audioPath
        self.text = text
    }
    
    func getImagePath() -> String {
        return imagePath!
    }
    
    func getILabel() -> String {
        return label!
    }
    
    func getAudioPath() -> String {
        return audioPath!
    }
    
    func getText() -> String {
        return text!
    }
    
}
