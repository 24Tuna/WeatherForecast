//
//  ContentView.swift
//  Weather_24
//
//  Created by cmStudent on 2021/12/26.
//

import SwiftUI
@available(iOS 15,*)
struct ContentView: View {
    
    @State private var selection : Int = 0
    
    var body: some View {
        VStack{
            TabView(selection: self.$selection){
                //FIXME: あとでViewにする
                ToDayView()
                    .tag(0)
                Weeks()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .transition(.slide)
            .animation(.easeInOut)
            
            Spacer()
                .frame(height: 0)
            
            HStack{
                
                Spacer()
                
                Button {
                    self.selection = 0
                } label: {
                    Text("ToDay")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    self.selection = 1
                } label: {
                    Text("Weeks")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
            }
            .frame(height: 40)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
