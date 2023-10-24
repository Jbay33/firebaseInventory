//
//  Savior.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import Foundation
import Firebase

struct Savior{
    
    static let db = Firestore.firestore()
    
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
    
    static func uploadToFirebase(shirtColor: ShirtColor){
        
        
        
        db.collection("Shirt Colors").document("\(shirtColor.colorName)").setData(shirtColor.toDictionaryValues()) {
            err in
            if let error = err {
                print("ERROR saving data: \(error)")
            }
            print("Sucessfuly saved data")
        }
    }
    
    
}
