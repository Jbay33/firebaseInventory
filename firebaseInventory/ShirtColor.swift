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
    
    func toDictionaryValues() -> [String: Any]
    {
        //format
        return [
            "color": colorName,
            "XXXL": sizes[0],
            "XXL": sizes[1],
            "XL": sizes[2],
            "L": sizes[3],
            "M": sizes[4],
            "S": sizes[5]
        ]
    }
    
    init(data: [String: Any]) {
        colorName = data["color"] as? String ?? ""
        sizes = [0, 0, 0, 0, 0, 0]
        sizes[0] = data["XXXL"] as? Int ?? 0
        sizes[1] = data["XXL"] as? Int ?? 0
        sizes[2] = data["XL"] as? Int ?? 0
        sizes[3] = data["L"] as? Int ?? 0
        sizes[4] = data["M"] as? Int ?? 0
        sizes[5] = data["S"] as? Int ?? 0
    }
 
    
}
