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
        
        // Les deux lignes ci-dessous déclenchent la popup de demande de permission de la position de l'utilisateur. Les permissions doivent être au préalable définies dans le fichier Info.plist
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = context.coordinator
        
        // Permet d'afficher la position de l'utilisateur sur la carte si les pemissions ont été acceptées
        mapView.showsUserLocation = true
        
        // Permet d'ajouter les annotations
        mapView.addAnnotations(annotations)
        
        // Permet de centrer la map sur la position de la première annotation
        mapView.setCenter(annotations[0].coordinate, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) { }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(parent: self)
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // On récupère le type du refuge si l'annotation est de type `RefugeAnnotation`
            guard let refugeType = (annotation as? RefugeAnnotation)?.type else {
                return nil
            }
            
            // Permet de laisser la position de l'utilisateur et ne pas la remplacer par une annotation de refuge
            if annotation is MKUserLocation {
                return nil
            }
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: refugeType.rawValue)
                
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: refugeType.rawValue)
            } else {
                annotationView?.annotation = annotation
            }
            
            // Pour configurer la popup qui s'affiche en cliquant sur l'annotation
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return annotationView
        }
        
        // Lorsque l'on clique sur la popup de callout, ce code déclenche la navigation
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            parent.selectedRefugeAnnotation = view.annotation as? RefugeAnnotation
            parent.isActive = true
        }
        
        /// Location Manager Delegate
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print(locations)
        }
    }
}
