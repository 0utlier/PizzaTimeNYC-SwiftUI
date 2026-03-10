//
//  PPData.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/25/26.
//

import Foundation
import SwiftUI
import CoreLocation

enum Rating: Int {//0,1,2//
    case RATEDNOT
    case RATEDLIKE
    case RATEDDISLIKE
}

struct PizzaPlace: Identifiable {
    //information on PizzaPlace
    var name: String
    let id = UUID()
    //    var url: String
    //    var image: String
    
    //location of PizzaPlace
//    var address: String
        var street: String
        var city: String
        var zip: Int
    var coordinate: CLLocationCoordinate2D
    var distance: Double
    
    //rating of PizzaPlace
    var userRating: Rating = .RATEDNOT
    var percentageLikes: Float
    var percentageDislikes: Float
}

let hardCodeRating = Rating.RATEDNOT
let hardCodeLocation = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Buckingham Palace [2]
let hardCodeLikes: Float = 100.0
let hardCodeDislikes: Float = 0.0
let hardCodeDistance: Double = 1.3

var myfirstPlace: PizzaPlace!

var pizzaPlaces: [PizzaPlace] = [
    PizzaPlace(name: "TWO BROS 8TH ST", street: "8th St NYC", city: "NYC", zip: 10023, coordinate: hardCodeLocation, distance: hardCodeDistance, userRating: hardCodeRating, percentageLikes: hardCodeLikes, percentageDislikes: hardCodeDislikes),
    PizzaPlace(name: "TWO BROS 9TH AVE", street: "9th Ave", city: "NYC", zip: 10065, coordinate: hardCodeLocation, distance: hardCodeDistance, userRating: hardCodeRating, percentageLikes: hardCodeLikes, percentageDislikes: hardCodeDislikes),
    PizzaPlace(name: "99 CENT PIZZA", street: "Ave B", city: "NYC", zip: 10009, coordinate: hardCodeLocation, distance: hardCodeDistance, userRating: hardCodeRating, percentageLikes: hardCodeLikes, percentageDislikes: hardCodeDislikes),
    PizzaPlace(name: "FOURTHPLACE", street: "address here", city: "NYC", zip: 10010, coordinate: hardCodeLocation, distance: hardCodeDistance, userRating: hardCodeRating, percentageLikes: hardCodeLikes, percentageDislikes: hardCodeDislikes)
]
