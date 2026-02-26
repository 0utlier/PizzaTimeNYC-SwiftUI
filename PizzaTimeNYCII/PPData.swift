//
//  PPData.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/25/26.
//

import Foundation
import SwiftUI
//import CoreLocation

struct PizzaPlace: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var rating: Double
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

var myfirstPlace: PizzaPlace!
var pizzaPlaces: [PizzaPlace] = [
    PizzaPlace(name: "firstPlace", address: "addressing", rating: 1.0, distance: 1.0),
    PizzaPlace(name: "secondPlace", address: "addressing", rating: 1.0, distance: 1.0),
    PizzaPlace(name: "thirdPlace", address: "addressing", rating: 1.0, distance: 1.0),
    PizzaPlace(name: "fourthPlace", address: "addressing", rating: 1.0, distance: 1.0),
]
