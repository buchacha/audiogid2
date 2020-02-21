//
//  Constants.swift
//  audiogid2
//
//  Created by  admin on 02.12.2019.
//  Copyright © 2019  admin. All rights reserved.
//

import UIKit

var text:String = "texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext"

class Constants: NSObject {
    
    static let audio1 = AudioItem("secondImage", NSLocalizedString("1_item_label", comment: ""), "1", text)
    static let audio2 = AudioItem("secondImage", NSLocalizedString("2_item_label", comment: ""), "2", text)
    static let audio3 = AudioItem("secondImage", NSLocalizedString("3_item_label", comment: ""), "3", text)
    static let audio4 = AudioItem("secondImage", NSLocalizedString("4_item_label", comment: ""), "4", text)
    static let audio5 = AudioItem("secondImage", NSLocalizedString("5_item_label", comment: ""), "5", text)
    
    static let audios:[AudioItem] = [audio1, audio2, audio3, audio4, audio5]

}
