//
//  PizzaMapView.swift
//  PizzaTimeNYCII
//

import SwiftUI
import MapKit

struct PizzaMapView: UIViewRepresentable {
    @Binding var centerTrigger: Bool
    @Binding var droppedCoordinate: CLLocationCoordinate2D?
    @ObservedObject var locationManager: LocationManager
    let pizzaPlaces: [PizzaPlace]

    let innerRadius: CLLocationDistance = 804.67  // half mile — red sauce
    let outerRadius: CLLocationDistance = 1100    // outer crust ring — yellow

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        mapView.showsCompass = false

        // NYC fallback region
        let fallback = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(fallback, animated: false)

        // Add confirmed pizza place pins
        for place in pizzaPlaces {
            let annotation = PizzaAnnotation(coordinate: place.coordinate, title: place.name)
            mapView.addAnnotation(annotation)
        }

        // Long press to drop a pin
        let longPress = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLongPress(_:))
        )
        longPress.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPress)

        context.coordinator.mapView = mapView
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        guard let location = locationManager.userLocation else { return }

        // User annotation — add once, update coordinate after
        if let existing = mapView.annotations.first(where: { $0 is UserAnnotation }) as? UserAnnotation {
            existing.coordinate = location.coordinate
        } else {
            mapView.addAnnotation(UserAnnotation(coordinate: location.coordinate))
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 2000,
                longitudinalMeters: 2000
            )
            mapView.setRegion(region, animated: true)
        }

        // Dropped pin — mirror the binding
        let existingDrop = mapView.annotations.first(where: { $0 is DroppedPinAnnotation })
        if let coord = droppedCoordinate {
            if existingDrop == nil {
                mapView.addAnnotation(DroppedPinAnnotation(coordinate: coord))
            }
        } else {
            if let pin = existingDrop {
                mapView.removeAnnotation(pin)
            }
        }

        // Refresh pizza circles
        mapView.removeOverlays(mapView.overlays)
        let outerCircle = MKCircle(center: location.coordinate, radius: outerRadius)
        outerCircle.title = "outer"
        let innerCircle = MKCircle(center: location.coordinate, radius: innerRadius)
        innerCircle.title = "inner"
        mapView.addOverlay(outerCircle)
        mapView.addOverlay(innerCircle)

        // Location button
        if centerTrigger {
            print("find me!")
            locationManager.centerOnUser(in: mapView)
            DispatchQueue.main.async { centerTrigger = false }
        }
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: PizzaMapView
        var mapView: MKMapView?

        init(_ parent: PizzaMapView) {
            self.parent = parent
        }

        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began, let mapView = mapView else { return }
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            DispatchQueue.main.async {
                self.parent.droppedCoordinate = coordinate
            }
        }

        // Circles
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                if circle.title == "inner" {
                    renderer.fillColor   = UIColor.red.withAlphaComponent(0.5)
                    renderer.strokeColor = UIColor.red.withAlphaComponent(0.8)
                } else {
                    renderer.fillColor   = UIColor.yellow.withAlphaComponent(0.5)
                    renderer.strokeColor = UIColor.yellow.withAlphaComponent(0.8)
                }
                renderer.lineWidth = 1
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }

        // Annotations
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            if annotation is UserAnnotation {
                let id = "userPin"
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: id)
                    ?? MKAnnotationView(annotation: annotation, reuseIdentifier: id)
                let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
                let icon = UIImage(systemName: "bicycle", withConfiguration: config)?
                    .withTintColor(.blue, renderingMode: .alwaysOriginal)
                let bg = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                bg.backgroundColor = .white
                bg.layer.cornerRadius = 20
                let imageView = UIImageView(image: icon)
                imageView.frame = CGRect(x: 9, y: 9, width: 22, height: 22)
                bg.addSubview(imageView)
                view.subviews.forEach { $0.removeFromSuperview() }
                view.addSubview(bg)
                view.frame = bg.frame
                view.annotation = annotation
                return view
            }

            if annotation is DroppedPinAnnotation {
                let id = "droppedPin"
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: id)
                    ?? MKAnnotationView(annotation: annotation, reuseIdentifier: id)
                view.image = UIImage(named: "pizzaSlice") ?? emojiImage("🍕", size: CGSize(width: 36, height: 36))
                view.frame.size = CGSize(width: 36, height: 36)
                view.annotation = annotation
                // Drop animation
                let endFrame = view.frame
                view.frame = view.frame.offsetBy(dx: 0, dy: -60)
                UIView.animate(withDuration: 0.3) { view.frame = endFrame }
                return view
            }

            if annotation is PizzaAnnotation {
                let id = "pizzaPin"
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: id)
                    ?? MKAnnotationView(annotation: annotation, reuseIdentifier: id)
                view.image = UIImage(named: "pizzaSlice") ?? emojiImage("🍕", size: CGSize(width: 36, height: 36))
                view.frame.size = CGSize(width: 36, height: 36)
                view.annotation = annotation
                return view
            }

            return nil
        }

        private func emojiImage(_ emoji: String, size: CGSize) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { _ in
                (emoji as NSString).draw(
                    in: CGRect(origin: .zero, size: size),
                    withAttributes: [.font: UIFont.systemFont(ofSize: size.width * 0.8)]
                )
            }
        }
    }
}
