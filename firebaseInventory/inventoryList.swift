//
//  inventoryList.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//

import SwiftUI
import Combine


struct inventoryList: View {
//    public static var arrayShirtColors:[ShirtColor] = Savior.loadFromUserDefaults() ?? [ShirtColor(colorName: "Red", sizes: [0,0,0,0,0,0])]
    var arraySizeMan:Int
    @State var milosHolyGrail = ""
    
    var colorNames:Array<String>
    @EnvironmentObject var vm:inventoryViewModel
    
    
    var body: some View {
       
        ZStack{
            
            
            GeometryReader { geometry in
                
                //goggle Sheets
                NavigationLink(){
                    //actually nothing
                    loading()
                } label: {
                    Image(systemName: "square.and.arrow.up")}
                .position(x:geometry.size.width/2+100,y:geometry.size.height/60+50)
                
                Button(){
                    vm.update()
                } label: {
                    Image(systemName: "square.and.arrow.down")}
                .position(x:geometry.size.width/2-100,y:geometry.size.height/60+50)
                
                
                
                
                //milosHolyButton
                Button(){
                    vm.arrayShirtColors.removeAll()
                    Savior.saveTouserDefaults(shirtArray: vm.arrayShirtColors)
                } label: {
                    Image(systemName: "gobackward")}
                .position(x:geometry.size.width/2,y:geometry.size.height/60+50)
                
                //text labels
                Text("Add to Inventory")
                    .position(x:100,y:geometry.size.height/60+50)
                Text("Add New Color")
                    .position(x:geometry.size.width-95,y:geometry.size.height/60+50)
                
                
                //add shirt button
                NavigationLink(){
                    addInventoryView(colorList: vm.colorListInv())
                } label: {
                    Image(systemName: "plus.app.fill")}
                .position(x:25,y:geometry.size.height/60+50)
                //add new color
                NavigationLink(){
                    addNewColorsView()
                } label: {
                    Image(systemName: "plus.app.fill")}
                .position(x:geometry.size.width-25,y:geometry.size.height/60+50)
                Text(milosHolyGrail)
                
                //display
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(0..<vm.arrayShirtColors.count, id: \.self) {i in
                            
                            ZStack {
                                
                                let name = colorListInv()
                                //background for display
                                Rectangle()
                                    .fill(Color("graya"))
                                    .frame(width: geometry.size.width, height: 200)
                                
                                //display info
                                let sizesNum = sizesAmount(colorOfShirt: vm.arrayShirtColors[i])
                                Text(name[i])
                                    .foregroundColor(.black)
                                    .position(x:geometry.size.width/3,y:100)
                                Text("XXXL: \(sizesNum[0])")
                                    .position(x:geometry.size.width*2/3-50,y:50)
                                Text("XXL: \(sizesNum[1])")
                                    .position(x:geometry.size.width*2/3-50,y:100)
                                Text("XL: \(sizesNum[2])")
                                    .position(x:geometry.size.width*2/3-50,y:150)
                                
                                Text("L: \(sizesNum[3])")
                                    .position(x:geometry.size.width*2/3+50,y:50)
                                Text("M: \(sizesNum[4])")
                                    .position(x:geometry.size.width*2/3+50,y:100)
                                Text("S: \(sizesNum[5])")
                                    .position(x:geometry.size.width*2/3+50,y:150)
                                
                            }
                        }
                    }
                }
                .padding(.top, geometry.size.height/6)
                .frame(width:geometry.size.width, height: geometry.size.height)
                .position(x:geometry.size.width/2, y:450)
                .refreshable {
                    //
                }
                
            }
        }.onAppear {
            milosHolyGrail = ""
            vm.arrayShirtColors = Savior.loadFromUserDefaults() ?? []
            vm.loadFromUserDefaults()
//            colorNames = vm.colorListInv()
//            arraySizeMan = colorNames.count
//            print(vm.toCSV_NOW());
        }
        
    }
    
    
    
    
    
    //func for names of colors
    func colorListInv()->Array<String>{
       var namesArray:[String] = []
       for i in 0..<vm.arrayShirtColors.count{
           namesArray.append(ShirtColor.getColorName(shirt: vm.arrayShirtColors[i]))
       }
       return namesArray
   }
    
    //func for sizes for each color
    func sizesAmount(colorOfShirt:ShirtColor)->Array<Int>{
        var shirtSizeAmount:[Int] = []
        for i in 0...5{
            shirtSizeAmount.append(colorOfShirt.sizes[i])
        }
        return shirtSizeAmount
    }
    

}


struct inventoryList_Previews: PreviewProvider {
    static var previews: some View {
        inventoryList(arraySizeMan: 0, colorNames: [])
    }
}



