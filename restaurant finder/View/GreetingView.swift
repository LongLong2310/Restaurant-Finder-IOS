/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 1
  Author: Pham Trinh Hoang Long
  ID: s3879366
  Created  30/07/2023
  Last modified: 04/08/2023
*/

import SwiftUI

struct GreetingView: View {
    @Binding var active: Bool
    @State var isPresentedStatus = false
    @State var uiWidth = UIScreen.main.bounds.width
    @State var uiHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isPresentedStatus = true;
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(Color.black)
                        .padding(.trailing)
//                        .offset(x: -50)
                }
                .alert(isPresented: $isPresentedStatus) {
                    Alert(title: Text("App Info"),
                    message: Text("Pham Trinh Hoang Long\n s3879366\n Restaurant Finder"))
                }
            }
            .padding(.top)
            
            Image("mainpage_enhance")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: uiWidth * 0.9)
                .padding(.all)
            
            Button(action: {
                active = false
            }, label: {
                Capsule()
                  .fill(Color.black)
                  .padding(8)
                  .frame(width: uiWidth * 0.8, height:uiHeight * 0.09)
                  .overlay(Text("Get Started")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white))
            })
            .padding(.top)
            .padding(.bottom)
        }
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView(active: .constant(true))
    }
}
