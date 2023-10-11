//
//  inventoryViewModel.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import Foundation
import Foundation
import AppKit

@MainActor
class inventoryViewModel: ObservableObject{
    
     @Published var arrayShirtColors:[ShirtColor] = Savior.loadFromUserDefaults() ?? [ShirtColor(colorName: "Red", sizes: [0,0,0,0,0,0])]
    
    init () {
        arrayShirtColors = Savior.loadFromUserDefaults() ?? []
    }
    
    @MainActor
     func colorListInv()->Array<String>{
       var namesArray:[String] = []
//       arrayShirtColors = Savior.loadFromUserDefaults() ?? []
       for i in 0..<arrayShirtColors.count{
           namesArray.append(ShirtColor.getColorName(shirt: arrayShirtColors[i]))
       }
       return namesArray
   }
    
    func loadFromUserDefaults()
    {
        arrayShirtColors = Savior.loadFromUserDefaults() ?? []
    }
    
    
    
    private func savePopup() -> URL? {
        let save = NSSavePanel();
        
        save.allowedContentTypes = [.commaSeparatedText ];
        
        save.canCreateDirectories = true;
        save.isExtensionHidden = true;
        save.allowsOtherFileTypes = false;
        save.title = "Save as CSV";
        save.message = "Choose a location to save the data.";
        save.nameFieldLabel = "Name:";
        
        let response = save.runModal()
        
        return response == .OK ? save.url : nil;
    }
    
    func toCSV_NOW() -> String {
        //todo
        let table = toCSV_LATER();
        
        var str = "";
        
        for i in 0..<table.count {
            for j in 0..<table[i].count {
                str += table[i][j];
                if j != table[i].count-1 {
                    str += ","
                } else {
                    str += "\n"
                }
            }
        }
        
        guard let url = savePopup() else { return "" }
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("died")
            return ""
        }
        
        return str;
    }
    
    private func toCSV_LATER() -> [[String]] {
        var table = [
            [""],
            ["XXXL"],
            ["XXL"],
            ["XL"],
            ["L"],
            ["M"],
            ["S"]
        ];
        
        for i in arrayShirtColors {
            let valList = i.toCSV();
            
            for j in 0..<valList.count {
                table[j].append(valList[j])
            }
        }
        
        return table
    }
    
    private func fromCSV_LATER(text: String) {
        let rows = text.split(separator: "\n")
        let namerow = (rows[0]).split(separator: ",")
        
        var names: [String] = []
        
        for i in 1..<namerow.count {
            names.append(String(namerow[i]))
        }
        
    }

    
//    static func colorListInv()->Array<String>{
//        var namesArray:[String] = []
//        for i in 0..<arrayShirtColors.count{
//            namesArray.append(ShirtColor.getColorName(shirt: arrayShirtColors[i]))
//        }
//        return namesArray
//    }
    
}
