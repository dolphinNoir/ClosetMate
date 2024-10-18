import SwiftData
import Foundation
import UIKit

@Model
class ClothingItem {
    @Attribute(.unique) var id: UUID
    @Attribute(.externalStorage) var frontImageData: Data?
    @Attribute(.externalStorage) var backImageData: Data?
    var itemName: String
    var itemCategory: ItemCategory
    var itemColor: ItemColor
    var itemBoughtFor: Int?
    var itemCurrentValue: Int?

    // Computed properties to access UIImage from stored Data
    var frontImage: UIImage? {
        get {
            guard let data = frontImageData else { return nil }
            return UIImage(data: data)
        }
        set {
            // Use pngData() to preserve transparency instead of jpegData()
            frontImageData = newValue?.pngData()
        }
    }

    var backImage: UIImage? {
        get {
            guard let data = backImageData else { return nil }
            return UIImage(data: data)
        }
        set {
            // Use pngData() to preserve transparency instead of jpegData()
            backImageData = newValue?.pngData()
        }
    }

    // Initializer
    init(frontImageData: Data?, backImageData: Data?, itemName: String, itemCategory: ItemCategory, itemColor: ItemColor, itemBoughtFor: Int? = nil, itemCurrentValue: Int? = nil) {
        self.id = UUID()
        self.frontImageData = frontImageData
        self.backImageData = backImageData
        self.itemName = itemName
        self.itemCategory = itemCategory
        self.itemColor = itemColor
        self.itemBoughtFor = itemBoughtFor
        self.itemCurrentValue = itemCurrentValue
    }
}

enum ItemCategory: String, Codable, Hashable, CaseIterable {
    case aLineSkirt = "A-Line Skirt"
    case ankleBoots = "Ankle Boots"
    case balletFlats = "Ballet Flats"
    case blazer = "Blazer"
    case blouse = "Blouse"
    case bodysuit = "Bodysuit"
    case bomberJacket = "Bomber Jacket"
    case boots = "Boots"
    case bralette = "Bralette"
    case cardigan = "Cardigan"
    case cargoPants = "Cargo Pants"
    case camisole = "Camisole"
    case chinos = "Chinos"
    case clogs = "Clogs"
    case coat = "Coat"
    case corset = "Corset"
    case cropTop = "Crop Top"
    case dress = "Dress"
    case dungarees = "Dungarees"
    case eveningDress = "Evening Dress"
    case espadrilles = "Espadrilles"
    case flipFlops = "Flip Flops"
    case heels = "Heels"
    case hoodie = "Hoodie"
    case jacket = "Jacket"
    case jeans = "Jeans"
    case joggers = "Joggers"
    case jumpsuit = "Jumpsuit"
    case kneeHighBoots = "Knee High Boots"
    case leatherJacket = "Leather Jacket"
    case leggings = "Leggings"
    case loafers = "Loafers"
    case maxiDress = "Maxi Dress"
    case midiDress = "Midi Dress"
    case miniDress = "Mini Dress"
    case mules = "Mules"
    case parka = "Parka"
    case pencilSkirt = "Pencil Skirt"
    case pleatedSkirt = "Pleated Skirt"
    case pufferJacket = "Puffer Jacket"
    case romper = "Romper"
    case sandals = "Sandals"
    case shirt = "Shirt"
    case shoes = "Shoes"
    case shorts = "Shorts"
    case skirt = "Skirt"
    case slipDress = "Slip Dress"
    case sneakers = "Sneakers"
    case sportsBra = "Sports Bra"
    case sweater = "Sweater"
    case tShirt = "T-Shirt"
    case tankTop = "Tank Top"
    case tracksuit = "Tracksuit"
    case trenchCoat = "Trench Coat"
    case trousers = "Trousers"
    case wedges = "Wedges"
    case wrapDress = "Wrap Dress"

    // Grouped Categories by Type
    static var groupedCategories: [String: [ItemCategory]] {
        return [
            "Tops": [.blazer, .blouse, .bodysuit, .bralette, .cardigan, .camisole, .corset, .cropTop, .hoodie, .jacket, .leatherJacket, .shirt, .sweater, .tShirt, .tankTop],
            "Bottoms": [.cargoPants, .chinos, .jeans, .joggers, .leggings, .shorts, .trousers],
            "Skirts": [.aLineSkirt, .pencilSkirt, .pleatedSkirt, .skirt],
            "Dresses & Jumpsuits": [.dress, .eveningDress, .maxiDress, .midiDress, .miniDress, .romper, .slipDress, .wrapDress, .jumpsuit, .dungarees],
            "Shoes": [.ankleBoots, .balletFlats, .boots, .clogs, .espadrilles, .flipFlops, .heels, .kneeHighBoots, .loafers, .mules, .sandals, .shoes, .sneakers, .wedges],
            "Outerwear": [.bomberJacket, .coat, .parka, .pufferJacket, .tracksuit, .trenchCoat],
            "Activewear": [.sportsBra]
        ]
    }
}

enum ItemColor : String, Codable, Hashable, CaseIterable{
    case lightestRed = "#FFCCCC"
       case lighterRed = "#FF9999"
       case lightRed = "#FF6666"
       case red = "#FF0000"
       case darkRed = "#CC0000"
       case darkestRed = "#990000"

       // Orange Shades
       case lightestOrange = "#FFE5CC"
       case lighterOrange = "#FFCC99"
       case lightOrange = "#FFB266"
       case orange = "#FF8C00"
       case darkOrange = "#CC7000"
       case darkestOrange = "#995200"

       // Yellow Shades
       case lightestYellow = "#FFFFCC"
       case lighterYellow = "#FFFF99"
       case lightYellow = "#FFFF66"
       case yellow = "#FFFF00"
       case darkYellow = "#CCCC00"
       case darkestYellow = "#999900"

       // Green Shades
       case lightestGreen = "#CCFFCC"
       case lighterGreen = "#99FF99"
       case lightGreen = "#66FF66"
       case green = "#00FF00"
       case darkGreen = "#009900"
       case darkestGreen = "#006600"

       // Blue Shades
       case lightestBlue = "#CCE5FF"
       case lighterBlue = "#99CCFF"
       case lightBlue = "#66B2FF"
       case blue = "#0000FF"
       case darkBlue = "#0000CC"
       case darkestBlue = "#000099"

       // Purple Shades
       case lightestPurple = "#F2CCFF"
       case lighterPurple = "#E6CCFF"
       case lightPurple = "#CC99FF"
       case purple = "#800080"
       case darkPurple = "#660066"
       case darkestPurple = "#4B0082"

       // Brown Shades
       case lightestBrown = "#EEDFCC"
       case lighterBrown = "#D2B48C"
       case lightBrown = "#C3A484"
       case brown = "#8B4513"
       case darkBrown = "#6F3B12"
       case darkestBrown = "#5C4033"

       // Gray Shades
       case lightestGray = "#F2F2F2"
       case lighterGray = "#D3D3D3"
       case lightGray = "#A9A9A9"
       case gray = "#808080"
       case darkGray = "#404040"
       case darkestGray = "#202020"

       // Black and White Shades
       case white = "#FFFFFF"
       case offWhite = "#F0F0F0"
       case lightBlack = "#3C3C3C"
       case black = "#000000"
       case jetBlack = "#0A0A0A"
       case pitchBlack = "#050505"
}




