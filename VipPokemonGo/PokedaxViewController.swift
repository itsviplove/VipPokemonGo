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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uncaughtPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let pokemon = uncaughtPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
