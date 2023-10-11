//
//  ShirtColor.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import Foundation
import Foundation

class ShirtColor:Codable {
    
       var colorName: String
       var sizes: Array<Int>
      static var listColor: Array<String> = []
    
    init(colorName: String, sizes: Array<Int>) {
        self.colorName = colorName
        self.sizes = sizes
        ShirtColor.listColor.append(colorName)
    }
    
    func toCSV() -> [String] {
        var column = [colorName];
        
        for i in sizes {
            column.append(String(i));
        }
        
        return column
    }
    
    func fromCSV(data: [String]) -> ShirtColor {
        var sizes: [Int] = []
        
        let name = data[0]
        
        for i in 1..<data.count {
            sizes.append(Int(data[i]) ?? 0)
        }
        
        return ShirtColor(colorName: name, sizes: sizes)
        
    }
    
    
      func addToColor(newShirts: Array<Int>){
        //adding inventory
        for i in 0..<6{
            sizes[i]+=newShirts[i]
        }
    }
    
    
    static func getColorName(shirt:ShirtColor)->String{
        return shirt.colorName
    }
    
}
