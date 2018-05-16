//
//  ViewController.swift
//  mapas
//
//  Created by DocAdmin on 5/16/18.
//  Copyright © 2018 ei. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 41.701497, longitude: -8.834756)
        centerMapOnLocation(location: initialLocation)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:)))
        mapView.addGestureRecognizer(tapGesture)
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        print("tapped")
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer){
        if sender.state.rawValue == 1{
            let touchLocation = sender.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            
            print("LongTapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            
            let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            
            geocoder.reverseGeocodeLocation(location) {
                (placemarks, error) in
                self.processResponseRev(withPlacemarks: placemarks, error: error)
            }
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 2000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation();
        point.coordinate = CLLocationCoordinate2D(latitude: 41.701497, longitude: -8.834756)
        point.title = "Marker1"
        point.subtitle = "Viana do Castelo"
        mapView.addAnnotation(point)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var geocoder = CLGeocoder()
    
    @IBAction func clickSegControl(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex){
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            print(view.annotation!.title!!)
            print(view.annotation!.subtitle!!)
            print(view.annotation!.coordinate)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reusedId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusedId) as? MKPinAnnotationView
        
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reusedId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        let button = UIButton(type: .detailDisclosure) as UIButton
        
        pinView?.rightCalloutAccessoryView = button
        
        return pinView
    }
    
    @IBAction func butGeocoding(_ sender: Any) {
        geocoder.geocodeAddressString(texttoGeo.text!) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
            
        }
    }
    

}

