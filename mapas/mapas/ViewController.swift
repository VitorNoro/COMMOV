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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager = CLLocationManager()
    var coordinateInMap : CLLocation!
    var latestLocation : CLLocation!
    var somePoints = [CLLocationCoordinate2D]()

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
        
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        
        let newCoord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locationCoordinate.latitude, locationCoordinate.longitude)
        
        somePoints.append(newCoord)
        if(somePoints.count == 4){
            addBoundary()
        }
    }
    
    func addBoundary(){
        let polygon = MKPolygon(coordinates: &somePoints, count: somePoints.count)
        mapView.add(polygon)
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
            calculateRota(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        }
        
        
    }

    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 2000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation();
        let cll = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        point.coordinate = cll
        point.title = "Marker1"
        point.subtitle = "Viana do Castelo"
        mapView.addAnnotation(point)
        
        mapView.add(MKCircle(center: cll, radius: 200))
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var labelGeoc: UILabel!
    @IBOutlet weak var texttoGeo: UITextField!
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
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?){
        if let error = error {
            print("Unable to geocode address (\(error))")
            labelGeoc.text = "Não foi possível encontrar o endereço"
        } else{
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                labelGeoc.text = "\(coordinate.latitude), \(coordinate.longitude)"
                centerMapOnLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
                coordinateInMap = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            } else {
                labelGeoc.text = "Não foi possível encontrar o endereço"
            }
        }
    }
    
    private func processResponseRev(withPlacemarks placemarks: [CLPlacemark]?, error: Error?){
        if let error = error {
            print("Unable to geocode address (\(error))")
            labelGeoc.text = "Não foi possível encontrar o endereço"
        } else{
            if let placemarks = placemarks, let placemark = placemarks.first {
                labelGeoc.text = "\(placemark.country!) - \(placemark.locality!) - \(placemark.postalCode!) - \(placemark.name!)"
            } else {
                labelGeoc.text = "Não foi possível encontrar o endereço"
            }
        }
    }
    
    @IBAction func onde_estou(_ sender: UIButton) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation = locations[locations.count - 1]
        
        var result = "Latitude" + String(format: "%.4f", latestLocation.coordinate.latitude)
        
        result = result + "Longitude" + String(format: "%.4f", latestLocation.coordinate.longitude)
        
        labelGeoc.text = result
        
        result = result + "Horizontal accuracy: " + String(format: "%.4f", latestLocation.horizontalAccuracy)
        
        result = result + "Altitude: " + String(format: "%.4f", latestLocation.altitude)
        
        result = result + "Vertical accuracy" + String(format: "%.4f", latestLocation.verticalAccuracy)
        
        print(result)
    }
    
    @IBAction func butDistancia(_ sender: UIButton) {
        let distanceBetween : CLLocationDistance = latestLocation.distance(from: coordinateInMap)
        
        labelGeoc.text = String(format: "%.2f", distanceBetween) + " metros"
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = UIColor.lightGray
            return circleRenderer
        }
        
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.magenta
            return polygonView
        }
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func calculateRota(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), addressDictionary: nil))
        request.destination = MKMapItem(placemark:	 MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude), addressDictionary: nil))
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate(completionHandler: {(response, error) in
            
            if error != nil{
                print("Error getting directions")
            } else {
                self.showRoute(response!)
            }
            
        })
    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        for route in response.routes{
            mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            for step in route.steps{
                print(step.instructions)
            }
        }
    }
}

