//
//  addInventoryView.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import SwiftUI

struct addInventoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var colorChoice = "Red"
    @State private var milosHolyGrail = false
    @State var XXXL = ""
    @State var XXL = ""
    @State var XL = ""
    @State var L = ""
    @State var M = ""
    @State var S = ""
    @State var submit = false
    @FocusState var boolXXXL
    @FocusState var boolXXL
    @FocusState var boolXL
    @FocusState var boolL
    @FocusState var boolM
    @FocusState var boolS
    
    @State var sizesArray:[Int] = []
    @State var colorList:Array<String>
    
    @EnvironmentObject var vm:inventoryViewModel
    
    var body: some View {
        
        ZStack{
            GeometryReader { geometry in
                
                //end navView
                
                
                //textfields
                Picker("Color Selection", selection: $colorChoice) {
                    ForEach(colorList, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .position(x:geometry.size.width/4,y:geometry.size.height/2)
                .frame(width:180)
                TextField("XXXL", text: $XXXL)
                    .position(x:geometry.size.width*3/4,y:150)
                    .frame(width: 100)
                    .focused($boolXXXL)
                    .onSubmit {
                        boolXXL = true
                    }
                TextField("XXL", text: $XXL)
                    .position(x:geometry.size.width*3/4,y:250)
                    .frame(width: 100)
                    .onSubmit {
                        boolXL = true
                    }
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
                
                //submit
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
                        var colorIndex:Int = 0
                        for i in 0..<colorList.count{
                            if(ShirtColor.getColorName(shirt: vm.arrayShirtColors[i])==colorChoice){
                                colorIndex=i
                            }
                        }
                        vm.arrayShirtColors[colorIndex].addToColor(newShirts: sizesArray)
                        milosHolyGrail = true
                        print("Inv add")
                        Savior.saveTouserDefaults(shirtArray: vm.arrayShirtColors)
                        dismiss()
                    }
                    Button("No", role:.cancel){ }

                }.position(x:geometry.size.width/2,y:15)

            }
        }.onAppear {
            colorList = vm.colorListInv()
            vm.loadFromUserDefaults()
        }
    }
}

struct addInventoryView_Previews: PreviewProvider {
    @EnvironmentObject var vm:inventoryViewModel
    static var previews: some View {
        addInventoryView(colorList: [])
    }
}
