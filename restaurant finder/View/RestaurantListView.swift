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

struct Event: Identifiable, Equatable {
    let id: Int
    let name: String
    // Other properties of the event
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}

struct RestaurantListView: View {
    @State private var searchText = ""
    @State private var didTap:Bool = false
    @State private var selectedEvent: Event?
    @State private var currentSelectedEvent: Event?
    @State private var buttonColor: Color = Color.blue
    @State private var activeFilter = ""
    @AppStorage("isDarkMode") private var isDark = false
    
    let events = [
        Event(id: 0, name: "Cafe"),
        Event(id: 1, name: "Bakery"),
        Event(id: 2, name: "Chinese"),
        Event(id: 3, name: "Vegetarian"),
    ]
    
    var body: some View {
        var columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
        
        NavigationStack {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                        .padding(.leading)
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                        .padding(.trailing)
                }
                
                HStack {
                    Text("Explore Restaurants")
                        .font(.system(size: 30, weight: .light, design: .serif))
                        .italic()
                        .bold()
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                .padding(.leading)
                
                HStack(alignment: .center) {
                    Spacer()
                    ScrollView(.horizontal) {
                        HStack(alignment: .center) {
                            ForEach(events) { event in
                                VStack {
                                    Button(action: {
                                        if selectedEvent == event {
                                            selectedEvent = nil
                                            activeFilter = ""
                                        } else {
                                            selectedEvent = event
                                            activeFilter = event.name
                                        }
                                    }) {
                                        Text(event.name)
                                            .font(.system(.caption))
                                            .bold()
                                            .foregroundColor(event == selectedEvent ? Color.white : Color.primary)
                                    }
                                    .frame(width: 80, height: 30, alignment: .center)
                                    .background(event == selectedEvent ? Color(hex: "#F4AE72") : isDark ? Color.black : Color.white)
                                    .cornerRadius(50)
                                }
                            }
                        }
                        .padding()
                        .padding(.leading)
                    }
//                    .background(Color.blue)
//                    .searchable(text: $searchText)
                }
                
                var searchedContacts: [Restaurant] {
                    if (searchText.isEmpty) {
                        return restaurants
                    } else {
                        return restaurants.filter { contact in
                            return contact.name.lowercased().contains(searchText.lowercased())
                        }
                    }
                }
                
                var filteredContacts: [Restaurant] {
                    if activeFilter.isEmpty {
                        return searchedContacts
                    } else {
                        return searchedContacts.filter { contact in
                            return contact.category.lowercased().contains(activeFilter.lowercased())
                        }
                    }
                }
                
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing:20) {
                            ForEach(filteredContacts) { restaurant in
                                NavigationLink(destination: RestaurantCard(restaurant: restaurant, isDark: isDark)) {
                                    RestaurantRow(restaurant: restaurant, isDark: isDark)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    Button(action: {isDark.toggle()}, label: {
                        isDark ? Label("Dark", systemImage: "lightbulb.fill") :
                        Label ("Dark", systemImage: "lightbulb")
                    })
                    .padding(.bottom)
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
    
    struct RestaurantListView_Previews: PreviewProvider {
        static var previews: some View {
            RestaurantListView()
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
    
