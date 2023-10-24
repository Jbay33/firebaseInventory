//
//  addNewColorsView.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import SwiftUI
import Firebase


struct addNewColorsView: View {

    enum FocusedField {
            case newColorName, XXXL, XXL
        }
    
    @State var newColorName = ""
    @State var XXXL = ""
    @State var XXL = ""
    @State var XL = ""
    @State var L = ""
    @State var M = ""
    @State var S = ""
    @State var submit = false
    @FocusState var focus:Bool
    @State var sizesArray:[Int] = []
    @FocusState private var focusedField: FocusedField?
    
    @EnvironmentObject var vm:inventoryViewModel
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        ZStack{
            GeometryReader { geometry in
                
                //textfields
                TextField("New Color", text: $newColorName)
                    .position(x:geometry.size.width/4,y:geometry.size.height/2)
                    .frame(width: 100)
                    .focused($focusedField, equals: .newColorName)
                
                TextField("XXXL", text: $XXXL)
                    .position(x:geometry.size.width*3/4,y:150)
                    .frame(width: 100)
                    .focused($focusedField, equals: .XXXL)
                TextField("XXL", text: $XXL)
                    .position(x:geometry.size.width*3/4,y:250)
                    .frame(width: 100)
                TextField("XL", text: $XL)
                    .position(x:geometry.size.width*3/4,y:350)
                    .frame(width: 100)
                TextField("L", text: $L)
                    .position(x:geometry.size.width*3/4,y:450)
                    .frame(width: 100)
                TextField("M", text: $M)
                    .position(x:geometry.size.width*3/4,y:550)
                    .frame(width: 100)
                TextField("S", text: $S)
                    .position(x:geometry.size.width*3/4,y:650)
                    .frame(width: 100)
                
                //submit button
                Button("Submit"){
                    submit=true
                }.alert("Do you want to submit?",isPresented: $submit) {
                    Button("Yes", role: .cancel) {
                        sizesArray.append(Int(XXXL) ?? 0)
                        sizesArray.append(Int(XXL) ?? 0)
                        sizesArray.append(Int(XL) ?? 0)
                        sizesArray.append(Int(L) ?? 0)
                        sizesArray.append(Int(M) ?? 0)
                        sizesArray.append(Int(S) ?? 0)
                        vm.arrayShirtColors.append(ShirtColor(colorName: newColorName, sizes: sizesArray))
                        Savior.saveTouserDefaults(shirtArray: vm.arrayShirtColors)
                        Savior.uploadToFirebase(shirtColor: ShirtColor(colorName: newColorName, sizes: sizesArray))
                        dismiss()
                    }
                    Button("No", role:.cancel){ }
                    
                }.position(x:geometry.size.width/2,y:15)
                
                
            }
        }.onAppear{
            vm.loadFromUserDefaults()
        }
        
    }
    
}

struct addNewColorsView_Previews: PreviewProvider {
    static var previews: some View {
        addNewColorsView()
    }
}
