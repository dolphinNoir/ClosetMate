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
    @Published var isLoading : Bool = true
    
   
    func setFrontImage(Image:UIImage){
        self.FrontImage = Image
    }

    func setBackImage(Image:UIImage){
        self.BackImage = Image
    }
    
    func clearImages(){
        self.BackImage = nil
        self.FrontImage = nil
    }
    
    func areBothImagesFilled() -> Bool{
        var isTrue = false
        
        if self.BackImage != nil && self.FrontImage != nil{
            isTrue = true
        }
        
        else{
            isTrue = false
        }
        
        return isTrue
    }
    
    func ConvertImages(){
        let backgroundRemoval = BackgroundRemoval()
        do {
            print("converting images")
            guard let front = FrontImage else {return}
            guard let back = BackImage else {return}
            self.isLoading = true
            self.FrontImage = try backgroundRemoval.removeBackground(image: front)
            self.BackImage = try backgroundRemoval.removeBackground(image: back)
            self.isLoading = false
        } catch {
            print(error)
        }
    }
}
