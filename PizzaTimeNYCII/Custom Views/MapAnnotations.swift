//
//  MapAnnotations.swift
//  PizzaTimeNYCII
//

import MapKit

class PizzaAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}

class UserAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    let title: String? = "You"
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

// Temporary pin shown while the new place prompt is visible
class DroppedPinAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String? = "New Place?"
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
