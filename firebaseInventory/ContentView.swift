//
//  ContentView.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//


import SwiftUI

struct ContentView: View {
    
    @State var showingAlert = false
    @State private var colorChoice = "Red"
    @State private var sizeChoice = "M"
    @State var password = ""
    var shirtColor = ShirtColor(colorName: "Red", sizes: [0])
    var shirtArray = 0
    @State var milosHolyGrail = false
    var colorList:Array<String> = []
    var sizesArray = ["XXXL","XXL","XL","L","M","S"]
    
    @EnvironmentObject var vm: inventoryViewModel
    

    
    var body: some View {
        
        NavigationStack {
            ZStack{
                GeometryReader { geometry in

                    SecureField("Password", text: $password)
                        .position(x:geometry.size.width/2+100, y:15)
                        .frame(width: 90)
                        
                    
                    NavigationLink {
                        
                        if (password==""){
                            inventoryList(arraySizeMan: vm.colorListInv().count, colorNames: vm.colorListInv())
                            
                        }
                    } label: {
                        Text("Inventory")
                    }
                    .position(x:geometry.size.width/2, y:15)
                    
                  //text box
                    Picker("Color Selection", selection: $colorChoice) {
                        ForEach(vm.colorListInv(), id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .position(x:geometry.size.width/3, y:(geometry.size.height/4))
                    .frame(width: 190)
                    
                    Picker("Size", selection: $sizeChoice) {
                        ForEach(sizesArray, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .position(x:geometry.size.width*2/3, y:(geometry.size.height/4))
                    .frame(width: 100)
                    
                    
                    
                    //confirmation alert
                    
                    Button("Submit"){
                        showingAlert = true
                    }.alert("Are you sure you want \(colorChoice): \(sizeChoice)", isPresented: $showingAlert) {
                        Button("Yes", role: .cancel) {
                            removeColor(color: colorChoice, size: sizeChoice)
                            
                        }
                        Button("No", role:.cancel){ }
                    }.position(x:geometry.size.width/2,y:geometry.size.height*2/4)
                    
                }
            }.onAppear{
                
            }
        }.onAppear {
            milosHolyGrail.toggle()
            colorChoice = vm.arrayShirtColors[0].colorName
            
        }
    }
    
    
     func removeColor(color:String, size: String){
        //removes inventory
        var colorIndex:Int = 0
         for i in 0..<vm.colorListInv().count{
            if(ShirtColor.getColorName(shirt: vm.arrayShirtColors[i])==color){
                colorIndex=i
            }
        }
        if (size=="XXXL"){
            vm.arrayShirtColors[colorIndex].sizes[0] -= 1
        }
        if (size=="XXL"){
            vm.arrayShirtColors[colorIndex].sizes[1] -= 1
        }

        if (size=="XL"){
            vm.arrayShirtColors[colorIndex].sizes[2] -= 1
        }

        if (size=="L"){
            vm.arrayShirtColors[colorIndex].sizes[3] -= 1
        }

        if (size=="M"){
            vm.arrayShirtColors[colorIndex].sizes[4] -= 1
        }

        if (size=="S"){
            vm.arrayShirtColors[colorIndex].sizes[5] -= 1
        }
         Savior.uploadToFirebase(shirtColor: vm.arrayShirtColors[colorIndex])
    }
 
    
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
            .environmentObject(inventoryViewModel())
    }
}

