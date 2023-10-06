//
//  ContentView.swift
//  restaurant finder
//
//  Created by Phạm Long on 24/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State var active = false
    @State var isPresentedStatus = false
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 300)
                Button(action: {
                    isPresentedStatus = true;
                    // Action for the button
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(Color.black)
//                        .offset(x: -50)
                }
                .alert(isPresented: $isPresentedStatus) {
                    Alert(title: Text("I am rich"),
                    message: Text("I am rich, I am deserve it, I am good, healthy, and successful"))
                }
            }
            
            Image("mainpage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
//                .padding(.all, 50.0)
            
            Button(action: {
                                active = false
                            }, label: {
                                Capsule()
                                  .fill(Color.black.opacity(0.2))
                                  .padding(8)
                                  .frame(height:80)
                                  .overlay(Text("Get Started")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white))
                            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
