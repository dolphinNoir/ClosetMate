//
//  Tips.swift
//  ClosetMate
//
//  Created by johnny basgallop on 26/09/2024.
//

import Foundation
import SwiftUI
import TipKit


struct ScanClothingTip : Tip {
    var title: Text {
        Text("Add a new Item")
    }
    
    var message: Text? {
        Text("Take a photo or upload a photo to scan the item")
    }
    
    var image: Image? {
        Image(systemName: "tshirt")
    }
}

struct ScanningAdviceTip : Tip {
    var title: Text {
        Text("Our Advice")
    }
    
    var message: Text? {
        Text("Try to make sure the clothing item is in the centre of the frame")
    }
    
    var image: Image? {
        Image(systemName: "lightbulb.max")
    }
}
