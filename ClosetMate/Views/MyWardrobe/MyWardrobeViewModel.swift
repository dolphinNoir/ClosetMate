//
//  MyWardrobeViewModel.swift
//  ClosetMate
//
//  Created by johnny basgallop on 22/09/2024.
//

import Foundation
import SwiftUI
import BackgroundRemoval

class MyWardrobeViewModel: ObservableObject {    
    @Published var FrontImage : UIImage?
    @Published var BackImage : UIImage?
    @Published var isLoading : Bool = false
    
   
    func setFrontImage(Image:UIImage){
        self.FrontImage = Image
    }

    func setBackImage(Image:UIImage){
        self.BackImage = Image
    }
    
    func ConvertImages(){
        let backgroundRemoval = BackgroundRemoval()
        do {
            print("converting images")
            guard let front = FrontImage else {return}
            self.isLoading = true
            self.FrontImage = try backgroundRemoval.removeBackground(image: front)
            self.isLoading = false
        } catch {
            print(error)
        }
    }
}
