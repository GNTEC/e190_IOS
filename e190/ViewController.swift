//
//  ViewController.swift
//  e190
//
//  Created by User on 08/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import SideMenu
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    //var mapView:MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupSideMenu()
        
        //configurar o navbar
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = true
        
        //Configurar o navbarText
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.center = (navigationController?.navigationBar.center)! //the put your image at the center
        
        let image = UIImage(named: "ui_ícone_logo")
        
        imageView.image = image
        
        navigationItem.titleView = imageView
        
//        //Tab Bar:
//        tabBarController?.tabBar.barTintColor = UIColor.brown
//        //Tab Bar Text:
//        tabBarController?.tabBar.tintColor = UIColor.yellow
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(!locations.isEmpty)
        {
            let myLocation = locations[0] as CLLocation
            
            mapView.setRegion(MKCoordinateRegionMake(myLocation.coordinate, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
    }
    

    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
        //SideMenuManager.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        // Create and Add MapView to our main view
//        createMapView()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        determineCurrentLocation()
//    }
//    
//    
//    func createMapView()
//    {
//        mapView = MKMapView()
//        
//        let leftMargin:CGFloat = 10
//        let topMargin:CGFloat = 60
//        let mapWidth:CGFloat = view.frame.size.width-20
//        let mapHeight:CGFloat = 300
//        
//    
//        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
//        mapView.mapType = MKMapType.standard
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        
//        // Or, if needed, we can position map in the center of the view
//        mapView.center = view.center
//        
//        view.addSubview(mapView)
//    }
//    
//    func determineCurrentLocation()
//    {
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            //locationManager.startUpdatingHeading()
//            locationManager.startUpdatingLocation()
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//        
//        // Call stopUpdatingLocation() to stop listening for location updates,
//        // other wise this function will be called every time when user location changes.
//        //manager.stopUpdatingLocation()
//        
//        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        mapView.setRegion(region, animated: true)
//        
//        // Drop a pin at user's Current Location
//        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
//        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//        myAnnotation.title = "Current location"
//        mapView.addAnnotation(myAnnotation)
//    }
//    
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
//    {
//        print("Error \(error)")
//    }
//    

}

