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

struct RestaurantRow: View {
    var restaurant: Restaurant
    var isDark = Bool()
    
    var body: some View {
        VStack(spacing: 3) {
            restaurant.image
                .resizable()
                .frame(width: 150, height: 100)
                .cornerRadius(15)
            Spacer().frame(height: 5)
            HStack {
                Text(restaurant.name)
                    .font(.system(size: 15, weight: .heavy, design: .default))
                    .foregroundColor(isDark ? Color.white : Color.black)
                Spacer()
                Image(systemName: restaurant.favorite ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(Color.red)
            }
            HStack {
                Text(restaurant.city)
                    .font(.system(size: 10, weight: .bold, design: .default))
                    .foregroundColor(Color.gray)
                Spacer()
            }
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12)
                    .foregroundColor(Color.yellow)
                Text(restaurant.rateNumber)
                    .font(.system(size: 12, weight: .heavy, design: .default))
                    .foregroundColor(isDark ? Color.white : Color.black)
                Text("(" + restaurant.rateNumber + ")")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(Color.gray)
                Spacer()
            }
        }
        .frame(width: 150)
    }
}

struct RestaurantRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RestaurantRow(restaurant: restaurants[0])
                .previewLayout(.fixed(width: 300, height: 70))
            RestaurantRow(restaurant: restaurants[1])
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
