//
//  ViewController.swift
//  VipPokemonGo
//
//  Created by keshav garg on 14/03/17.
//  Copyright © 2017 Viplove bansal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate , MKMapViewDelegate {
    
    
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
            
            setup()
            
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            setup()
        }
    }
    func setup() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        manager.startUpdatingLocation()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (Timer) in
            if let cord = self.manager.location?.coordinate {
                print("see")
                let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                
                let anno = PokeAnnotation(coord: cord, pokemon: pokemon)
                
                let randoLat = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                let randoLon = (Double(arc4random_uniform(200)) - 100.0) / 50000.0
                anno.coordinate.latitude += randoLat
                anno.coordinate.longitude += randoLon
                self.mapView.addAnnotation(anno)
            }})
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image = UIImage(named: "player")
            var frame = annoView.frame
            frame.size.height = 50
            frame.size.width = 50       
            annoView.frame = frame
            
            return annoView

        }
        let pokemon = (annotation as! PokeAnnotation).pokemon
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image = UIImage(named: pokemon.imageName!)
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        annoView.frame = frame
        return annoView
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        if view.annotation! is MKUserLocation {
            return
        }
        let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, 200 , 200)
        mapView.setRegion(region, animated: false)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if let cord = self.manager.location?.coordinate {
                
                if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(cord)) {
                    print("Can Catch the Pokemon")
                    let alertVC = UIAlertController(title: "Wow", message: "you got this Pokemon", preferredStyle: .alert)
                    let pokedaxAction = UIAlertAction(title: "Pokedax", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "pokedax", sender: nil)
                    })
                    alertVC.addAction(pokedaxAction)
                    
                    let OkAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertVC.addAction(OkAction)
                    self.present(alertVC, animated: true, completion: nil)
                    let pokemon = (view.annotation as! PokeAnnotation).pokemon
                    pokemon.caught = true
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    mapView.removeAnnotation(view.annotation!)
                    
                } else {
                    let alertVC = UIAlertController(title: "Oh-Oh", message: "This pokemon is too far away", preferredStyle: .alert)
                    let OkAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertVC.addAction(OkAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }

        }
            }
    
    
    @IBAction func centreTapped(_ sender: Any) {
        
        if let cord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(cord, 200 , 200)
            
            mapView.setRegion(region, animated: false)
        }
    }
    
    
    
    
    
}

