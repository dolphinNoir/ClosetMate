//
//  MyWardrobeViewModel.swift
//  ClosetMate
//
//  Created by johnny basgallop on 22/09/2024.
//

import Foundation
import SwiftUI

class MyWardrobeViewModel: ObservableObject {    
    @Published var FrontImage : UIImage?
    @Published var BackImage : UIImage?
    
    func setFrontImage(Image:UIImage){
        FrontImage = Image
    }

    func setBackImage(Image:UIImage){
        BackImage = Image
    }
}
