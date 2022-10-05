//
//  MapWrapperView.swift
//  swiftdemo
//
//  Created by 王守恒 on 2022/10/5.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapWrapperView: View {
    var location: Location

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )

    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [location]
        ) { location in
            MapPin(coordinate: location.coordinate)
        }
        .onAppear { region.center = location.coordinate }
        .frame(minWidth: 200,
               idealWidth: 300,
               maxWidth: .infinity,
               minHeight: 200,
               idealHeight: 350,
               maxHeight: .infinity
        )
        .cornerRadius(10)
    }
}

struct MapWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        MapWrapperView(location: Location(coordinate: CLLocationCoordinate2D()))
    }
}
