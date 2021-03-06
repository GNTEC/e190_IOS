//
//  MainViewController.swift
//  e190
//
//  Created by User on 16/05/17.
//  Copyright © 2017 GNTEC. All rights reserved.
//

import UIKit
import SideMenu
import MapKit
import CoreLocation


class MainViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setUpMaps()
        setupSideMenu()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //setupUI()
    }

    func setUpMaps () {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
 
    }
    
    func setupUI() {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.center = (navigationController?.navigationBar.center)! //the put your image at the center
        
        let image  = UIImage(named: "ui__ícone_logo")
    
        imageView.image = image
        navigationItem.titleView = imageView
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
        
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
