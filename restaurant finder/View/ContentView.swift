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

struct ContentView: View {
    @State var active = false
    @State var isPresentedStatus = false
    var body: some View {
        WelcomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
