//
//  ViewController.swift
//  VipPokemonGo
//
//  Created by keshav garg on 14/03/17.
//  Copyright © 2017 Viplove bansal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var pokemons : [Pokemon] = []
    var manager = CLLocationManager()
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemons = allPokemon()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("ready to go")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (Timer) in
                if let cord = self.manager.location?.coordinate {
                    print("see")
                    let anno = MKPointAnnotation()
                    anno.coordinate = cord
                    let randoLat = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    let randoLon = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                    anno.coordinate.latitude += randoLat
                    anno.coordinate.longitude += randoLon
                    self.mapView.addAnnotation(anno)
                }})
            
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("lets")
        if updateCount < 3 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            
            mapView.setRegion(region, animated: false)
            
            updateCount += 1
        } else {
            manager.stopUpdatingLocation()
        }
        
    }
    
    @IBAction func centreTapped(_ sender: Any) {
        
        if let cord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(cord, 200 , 200)
            
            mapView.setRegion(region, animated: false)
        }
    }
    
    
    
    
    
}

