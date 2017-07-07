//
//  MapView.swift
//  Foodie
//
//  Created by Zone 3 on 6/28/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView : UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    var didFindMyLocation = false
    var mapView : GMSMapView!
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 10.0)
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        determineMyCurrentLocation()
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
//            determineMyCurrentLocation()
            mapView.isMyLocationEnabled = true
            mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)

        }
    }
    
      func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSKeyValueChangeKey : Any], context: UnsafeMutableRawPointer) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change[NSKeyValueChangeKey.newKey] as! CLLocation
            mapView.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 10.0)
            print("user latitude = \(myLocation.coordinate.latitude)")
            print("user longitude = \(myLocation.coordinate.longitude)")
            mapView.settings.myLocationButton = true
            
            didFindMyLocation = true
        }
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        mapView.camera = GMSCameraPosition.camera(withTarget: userLocation.coordinate, zoom: 10.0)
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
