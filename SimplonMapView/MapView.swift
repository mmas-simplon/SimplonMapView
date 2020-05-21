//
//  MapView.swift
//  SimplonMapView
//
//  Created by Mickael Mas on 20/05/2020.
//  Copyright © 2020 APPIWEDIA. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    @Binding var selectedRefugeAnnotation: RefugeAnnotation?
    @Binding var isActive: Bool
    
    var annotations: [RefugeAnnotation]
    
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        
        // Configuration Location Manager
        
        locationManager.delegate = context.coordinator
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.addAnnotations(annotations)
        mapView.setCenter(annotations[0].coordinate, animated: true)
        mapView.showsUserLocation = true
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(parent: self)
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            parent.selectedRefugeAnnotation = view.annotation as? RefugeAnnotation
            parent.isActive = true
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            parent.selectedRefugeAnnotation = nil
            parent.isActive = false
        }
        
        /// Location Manager Delegate
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print(locations)
        }
    }
}
