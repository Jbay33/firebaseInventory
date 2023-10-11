//
//  Savior.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import Foundation

struct Savior{
    
    
    static func saveTouserDefaults(shirtArray: [ShirtColor]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(shirtArray)
            UserDefaults.standard.set(data, forKey: "shirtArray")
        } catch {
            // Fallback
        }
    }
    
    static func loadFromUserDefaults()->[ShirtColor]? {
        guard let data = UserDefaults.standard.data(forKey: "shirtArray") else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let colors = try decoder.decode([ShirtColor].self, from: data)
            return colors
        } catch {
            // Fallback
        }
        return nil
    }
    
    
    
    
}
