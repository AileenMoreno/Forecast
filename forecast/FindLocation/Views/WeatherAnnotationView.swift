//
//  WeatherAnnotationView.swift
//  forecast
//
//  Created by Aileen Gabriela Moreno Perez on 13-11-21.
//  Copyright © 2021 SHAPE A/S. All rights reserved.
//

import MapKit

class WeatherAnnotationView: MKPinAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
        rightCalloutAccessoryView = UIButton(type: .infoLight)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class WeatherAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = "(\(coordinate.latitude),\(coordinate.longitude))"
        self.coordinate = coordinate
    }
}
