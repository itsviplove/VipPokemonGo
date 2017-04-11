//
//  PokeAnno.swift
//  VipPokemonGo
//
//  Created by Viplove Bansal on 4/11/17.
//  Copyright © 2017 Viplove bansal. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    
    init(coord: CLLocationCoordinate2D , pokemon : Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
}
