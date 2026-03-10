//
//  PPData.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/25/26.
//

import Foundation
import SwiftUI
import CoreLocation

struct PizzaPlace: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var rating: Double
    var coordinate: CLLocationCoordinate2D
    var distance: Double
    //    var state: String
    //    var description: String
    
    
//    private var imageName: String
//    var image: Image {
//        Image(imageName)
//    }
//    
//    
//    private var coordinates: Coordinates
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }
//    
//    
//    struct Coordinates: Hashable, Codable {
//        var latitude: Double
//        var longitude: Double
//    }
}
let location = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Buckingham Palace [2]

var myfirstPlace: PizzaPlace!
var pizzaPlaces: [PizzaPlace] = [
    PizzaPlace(name: "TWO BROS 8TH ST", address: "8th St NYC", rating: 1.0, coordinate: location, distance: 1.0),
    PizzaPlace(name: "TWO BROS 9TH AVE", address: "9th Ave", rating: 1.0, coordinate: location, distance: 1.0),
    PizzaPlace(name: "99 CENT PIZZA", address: "Ave B", rating: 1.0, coordinate: location, distance: 1.0),
    PizzaPlace(name: "FOURTHPLACE", address: "addressing", rating: 1.0, coordinate: location, distance: 1.0),
]
