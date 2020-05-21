//
//  ContentView.swift
//  SimplonMapView
//
//  Created by Mickael Mas on 20/05/2020.
//  Copyright © 2020 APPIWEDIA. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedRefugeAnnotation: RefugeAnnotation?
    @State var isActive: Bool = false
    
    let refuges: [RefugeAnnotation] = [
        Refuge(name: "Le Boin Coin", adresse: "Paris", horaires: "H24", isOpen: true, type: .nightClub, latitude: 48.85369110, longitude: 2.37260294),
        Refuge(name: "Darty", adresse: "Paris", horaires: "H24", isOpen: true, type: .nightClub, latitude: 49.85369110, longitude: 2.57260294),
        Refuge(name: "Kiabi", adresse: "Paris", horaires: "H24", isOpen: true, type: .restauration, latitude: 47.85369110, longitude: 2.50260294)
        ].map { (refuge) -> RefugeAnnotation in
            RefugeAnnotation(refuge: refuge)
    }
    
    var body: some View {
        NavigationView {
            
            /* Lorsque la variable isActive passe à true, elle exécute la navigation automatiquement
             
             Pour que le code s'execute correctement, le NavigationLink doit être ecuté avant la MapView
             
             Inclure la MapView dans la ZStack permet d'avoir une navigation correcte
            */
            ZStack {
                if selectedRefugeAnnotation != nil {
                    NavigationLink(destination: RefugeAnnotationView(selectedRefugeAnnotation: selectedRefugeAnnotation), isActive: $isActive) {
                        EmptyView()
                    }
                }
                
                MapView(selectedRefugeAnnotation: $selectedRefugeAnnotation, isActive: $isActive, annotations: refuges)
                .navigationBarTitle("Refuges", displayMode: .inline)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct RefugeAnnotationView: View {
    var selectedRefugeAnnotation: RefugeAnnotation?

    var body: some View {
        VStack {
            Text(selectedRefugeAnnotation?.title ?? "Pas de refuge")
                .font(.largeTitle)
            Text(selectedRefugeAnnotation?.subtitle ?? "Pas d'adresse")
                .font(.headline)
                .foregroundColor(.red)
        }.navigationBarTitle("\(selectedRefugeAnnotation?.title ?? "Refuge")", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
