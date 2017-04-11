//
//  CoreDataHelper.swift
//  VipPokemonGo
//
//  Created by keshav garg on 15/03/17.
//  Copyright © 2017 Viplove bansal. All rights reserved.
//

import UIKit
import CoreData

func addPokemon() {
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Zubat", imageName: "zubat")
    createPokemon(name: "Ratata", imageName: "rattata")
    
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
}

func createPokemon(name: String, imageName : String) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemons = Pokemon(context: context)
    pokemons.name = name
    pokemons.imageName = imageName
    
    
    
}

func allPokemon() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
     let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            addPokemon()
            return allPokemon()
        }
        return pokemons
        
    } catch {}
    return []

}

func caughtPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
        let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
            fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
        
    
    do {
        
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        
        
        
        return pokemons
        
    } catch {}
    
    
    
    return []
}

func uncaughtPokemons() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %@",false as CVarArg)
    
    
    do {
        
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        
        
        
        return pokemons
        
    } catch {}
    
    
    
    return []
}

