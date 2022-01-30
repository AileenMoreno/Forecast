//
//  FindLocationViewController.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import MapKit
import Entities

protocol FindLocationViewControllerOutput: class {
    func viewIsReady()
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}

protocol FindLocationViewControllerAction: class {
    func routeToForecast(for coordinate: CLLocationCoordinate2D)
}

final class FindLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = MKMapView(frame: .zero)
    
    var output: FindLocationViewControllerOutput!
    var action: FindLocationViewControllerAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureMapView()
        output.viewIsReady()
    }
    
    private func configureNavigationController() {
        title = Constants.forecastTitle
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        configureMapViewConstraints()
        configureMapViewTapGesture()
        mapView.delegate = self
        
        mapView.register(WeatherAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func configureMapViewTapGesture() {
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(findLocation(_:)))
        mapView.addGestureRecognizer(gesture)
    }
    
    private func configureMapViewConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc
    private func findLocation(_ gesture: UITapGestureRecognizer) {
        var point = gesture.location(in: mapView)
        point.y = point.y +  84
        
        let coordinate = mapView.convert(point, toCoordinateFrom: nil)
        let annotation = WeatherAnnotation(title: Constants.annotationTitle,
                                           coordinate: coordinate)
        mapView.removeAnnotations(self.mapView.annotations)
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: false)
    }
}

// MARK: - FindLocationPresenterOutput
extension FindLocationViewController: FindLocationPresenterOutput {
    func showWeather(model: FindLocation.ViewModel.Success) {
        
        
        let annotation = WeatherAnnotation(title: Constants.annotationTitle,
                                           coordinate: model.coordinate)
        DispatchQueue.main.async() { [weak self] in
            
            guard let self = self else {
                return
            }
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func showError(model: FindLocation.ViewModel.Failure) {
        DispatchQueue.main.async() { [weak self] in
            
            guard let self = self else {
                return
            }
            
            let alert = UIAlertController(title: Constants.findLocationErrorTitle,
                                          message: model.message,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: Constants.findLocationErrorButtonTitle,
                                       style: .default,
                                       handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - MKMapViewDelegate
extension FindLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        let reuseIdentifier = "placemark"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = WeatherAnnotationView(annotation: annotation,
                                                   reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? WeatherAnnotation else { return }
        action.routeToForecast(for: annotation.coordinate)
    }
}

