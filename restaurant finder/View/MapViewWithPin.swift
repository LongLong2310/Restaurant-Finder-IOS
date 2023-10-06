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
import MapKit

struct MapViewWithPin: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var restaurant: Restaurant

        func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.delegate = context.coordinator
            return mapView
        }

        func updateUIView(_ uiView: MKMapView, context: Context) {
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            uiView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = restaurant.name
            uiView.addAnnotation(annotation)
        }

        func makeCoordinator() -> Coordinator {
            Coordinator()
        }

        class Coordinator: NSObject, MKMapViewDelegate {

        }
}

struct MapViewWithPin_Previews: PreviewProvider {
    static var previews: some View {
        MapViewWithPin(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), restaurant: restaurants[0])
    }
}
