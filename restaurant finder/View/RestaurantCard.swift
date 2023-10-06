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
import CoreLocation
import UIKit

struct RestaurantCard: View {
    var restaurant: Restaurant
    var isDark: Bool
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.20
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            MapViewWithPin(coordinate: restaurant.locationCoordinate, restaurant: restaurant)
            
            VStack {
                DetailView(restaurant: restaurant, isDark: isDark)
                    .offset(y: startingOffsetY)
                    .offset(y: currentDragOffsetY)
                    .offset(y: endingOffsetY)
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                withAnimation(.spring()) {
                                    currentDragOffsetY = value.translation.height
                                }
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    if(currentDragOffsetY > 40) {
                                        endingOffsetY = UIScreen.main.bounds.height * 0.75
                                        currentDragOffsetY = 0
                                    }
                                    else if(currentDragOffsetY < -50) {
                                        endingOffsetY = 0
                                        currentDragOffsetY = 0
                                    }
                                    else {
                                        currentDragOffsetY = 0
                                    }
                                }
                            }
                    )
            }
            
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
    }
}

struct RestaurantCard_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCard(restaurant: restaurants[5], isDark: true)
    }
}


struct DetailView: View {
    @State var uiWidth = UIScreen.main.bounds.width
    @State var uiHeight = UIScreen.main.bounds.height
    
    let restaurant: Restaurant
    var isDark: Bool
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "chevron.up")
                .padding(.top)
                .padding(.bottom)
            Image(restaurant.imageName).resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: uiHeight * 0.43, height: uiHeight * 0.3)
                .cornerRadius(30)
            
            HStack {
                Text(restaurant.name)
                    .font(.system(size: uiHeight * 0.035))
                    .bold()
                    .foregroundColor(isDark ? Color.white : Color.black)
                    .padding(.leading)
                Spacer()
            }
            .padding(.top)
            
            HStack {
                Text(restaurant.description)
                    .font(.system(size: uiHeight * 0.015))
                    .foregroundColor(isDark ? Color.white : Color.black)
                    .frame(maxWidth: 300, alignment: .leading)
                Spacer()
            }
            .padding(.leading)
            
            HStack {
                Text("Ho Chi Minh")
                    .font(.system(size: uiHeight * 0.015, weight: .bold, design: .default))
                    .foregroundColor(Color.gray)
                    .padding(.leading)
                Spacer()
            }
            
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: uiHeight * 0.014)
                    .foregroundColor(Color.yellow)
                Text(restaurant.rateNumber)
                    .font(.system(size: uiHeight * 0.014, weight: .heavy, design: .default))
                    .foregroundColor(isDark ? Color.white : Color.black)
                Text("(" + restaurant.rateAmount + ")")
                    .font(.system(size: uiHeight * 0.014, weight: .regular, design: .default))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding(.leading)
            
            let foodImages = restaurant.foods
            
            ScrollView(.horizontal) {
                VStack {
                    HStack(spacing: 10) {
                        ForEach(foodImages, id: \.self) { foodImages in
                            VStack {
                                Image(foodImages)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: uiHeight * 0.25, height: uiHeight * 0.14)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.top)
                    .padding(.trailing)
                }
            }
            
            HStack(alignment: .top) {
                VStack(spacing: 10) {
                    Image(systemName: "clock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: uiWidth * 0.11)
                        .foregroundColor(Color.yellow)
                    Text(restaurant.time)
                        .font(.system(size: uiHeight * 0.012, weight: .light, design: .default))
                }
                .padding(.leading)
                .padding(.top)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: uiWidth * 0.1)
                        .foregroundColor(Color.orange)
                    
                    Text(restaurant.distance)
                        .font(.system(size: uiHeight * 0.012, weight: .light, design: .default))
                }
                .padding(.top)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "box.truck")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: uiWidth * 0.15)
                        .foregroundColor(Color.pink)
                    Text(restaurant.delivery)
                        .font(.system(size: uiHeight * 0.012, weight: .light, design: .default))
                }
                .padding(.trailing)
                .padding(.top)
            }
            .padding(.bottom)
            .padding(.leading)
            .padding(.trailing)
            .frame(maxHeight: uiHeight * 0.115)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isDark ? Color.black : Color.white)
        .cornerRadius(30)
    }
}
