//
//  MapPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/10/26.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

// MARK: - Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func centerOnUser(in mapView: MKMapView) {
        guard let location = userLocation else { return }
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
}

// MARK: - Custom Annotation Models
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

// MARK: - MKMapView Representable
struct PizzaMapView: UIViewRepresentable {
    @Binding var centerTrigger: Bool
    @ObservedObject var locationManager: LocationManager
    let pizzaPlaces: [PizzaPlace] // your existing model
    
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
        
        // Add pizza place pins
        for place in pizzaPlaces {
            let annotation = PizzaAnnotation(coordinate: place.coordinate, title: place.name)
            mapView.addAnnotation(annotation)
        }
        
        context.coordinator.mapView = mapView
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        guard let location = locationManager.userLocation else { return }
        
        // Add user annotation once, update coordinate after
        if let existing = mapView.annotations.first(where: { $0 is UserAnnotation }) as? UserAnnotation {
            existing.coordinate = location.coordinate
        } else {
            let userAnnotation = UserAnnotation(coordinate: location.coordinate)
            mapView.addAnnotation(userAnnotation)
            
            // Center on user the first time
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 2000,
                longitudinalMeters: 2000
            )
            mapView.setRegion(region, animated: true)
        }
        
        // Refresh pizza circles around user
        mapView.removeOverlays(mapView.overlays)
        
        let outerCircle = MKCircle(center: location.coordinate, radius: outerRadius)
        outerCircle.title = "outer"
        let innerCircle = MKCircle(center: location.coordinate, radius: innerRadius)
        innerCircle.title = "inner"
        
        mapView.addOverlay(outerCircle) // outer first so inner renders on top
        mapView.addOverlay(innerCircle)
        
        // Location button tap
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
            
            // Bicycle pin for user
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
            
            // Pizza slice pin for places
            if annotation is PizzaAnnotation {
                let id = "pizzaPin"
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: id)
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: id)
                // Swap "pizzaSlice" for your actual asset name
                view.image = UIImage(named: "pizzaSlice") ?? emojiImage("🍕", size: CGSize(width: 36, height: 36))
                view.frame.size = CGSize(width: 36, height: 36)
                view.annotation = annotation
                return view
            }
            
            return nil
        }
        
        // Emoji fallback if asset is missing
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

// MARK: - Map Page
struct MapPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    
    @StateObject private var locationManager = LocationManager()
    @State private var centerTrigger = false
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.ptnColorYellow
                    .ignoresSafeArea()
                
                // MARK: Map fills entire screen
                ZStack(alignment: .bottomLeading) {
                    PizzaMapView(
                        centerTrigger: $centerTrigger,
                        locationManager: locationManager,
                        pizzaPlaces: pizzaPlaces
                    )
                    .ignoresSafeArea()
                    
                    Button(action: {
                        print("fine me!")
                        centerTrigger = true
                    }) {
                        Image("MCQMapLOCATION")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight / 20)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 0))
                }
                
                // MARK: Buttons float on top
                VStack {
                    HStack(spacing: screenWidth / 5) {
                        Button(action: searchButton) {
                            Image("MCQMapSEARCH")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        
                        Button(action: optionsButton) {
                            Image("MCQMapOPTIONS")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        
                        Button(action: soundButton) {
                            Image(musicState.isPlaying ? "MCQMapSOUND" : "MCQMapSOUNDNOT")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                    
                    Spacer()
                    
                    // MARK: Bottom Tab Bar
                    HStack {
                        Button(action: mapButton) {
                            Image("MCQTabBarMAP")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2)
                        }
                        .padding(EdgeInsets(top: -20, leading: 0, bottom: -200, trailing: -8))
                        
                        Button(action: listButton) {
                            Image("MCQTabBarLIST")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2)
                        }
                        .padding(EdgeInsets(top: -20, leading: 0, bottom: -200, trailing: 0))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Functions
    func soundButton() { musicState.isPlaying.toggle() }
    func mapButton()   { nav.lastPage = nav.activePage; nav.activePage = .map }
    func listButton()  { nav.lastPage = nav.activePage; nav.activePage = .list }
    func optionsButton() { nav.goHome() }
    func searchButton()  { print("search button pressed") }
}

#Preview {
    MapPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
