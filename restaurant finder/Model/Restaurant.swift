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

import Foundation
import SwiftUI
import CoreLocation

struct Restaurant: Identifiable, Codable{
    var id: Int
    var name: String
    var category: String
    var description: String
    var city: String
    var foods: [String]
    var rateNumber: String
    var rateAmount: String
    var favorite: Bool
    var time: String
    var distance: String
    var delivery: String

    var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}

