//
//  PokedaxViewController.swift
//  VipPokemonGo
//
//  Created by keshav garg on 15/03/17.
//  Copyright © 2017 Viplove bansal. All rights reserved.
//

import UIKit

class PokedaxViewController: UIViewController , UITableViewDelegate , UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    var caughtPokemon : [Pokemon] = []
    var uncaughtPokemon : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caughtPokemon = caughtPokemons()
        uncaughtPokemon = uncaughtPokemons()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Caught"
        } else {
            return "UnCaught"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokemon.count
        } else {
        
        return uncaughtPokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let pokemon : Pokemon
        if indexPath.section == 0 {
            pokemon = caughtPokemon[indexPath.row]
        } else {
            pokemon = uncaughtPokemon[indexPath.row]
        }
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        return cell
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
