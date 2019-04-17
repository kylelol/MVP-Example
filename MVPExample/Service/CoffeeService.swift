//
//  CoffeeService.swift
//  MVPExample
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import Foundation

struct CoffeeService {
    
    static func fetchAvailableCoffees(response: @escaping (Result<[Coffee]>) -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 5.0) {
            DispatchQueue.main.async {
                let coffees = generateArrayOfCoffees()
                response(.success(coffees))
            }
        }
    }
    
    private static func generateArrayOfCoffees() -> [Coffee] {
        let passenger = Roaster(name: "Passenger", location: "Pennsylvania")
        let comobiaSanRoque = Coffee(name: "Keystone", origin: "Seasonal Blend", process: "Blend", roaster: passenger)
        let geishaVillage = Coffee(name: "Geisha Village", origin: "Ethiopia", process: "Wet", roaster: passenger)
        let daterra = Coffee(name: "Daterra", origin: "Brazil", process: "Dry", roaster: passenger)
        let montecarlos = Coffee(name: "MonteCarlos Bourbon", origin: "El Savador", process: "Wet", roaster: passenger)
        let stowaway = Coffee(name: "Stowaway", origin: "Seasonal Blend", process: "Blend", roaster: passenger)
        let agaro = Coffee(name: "Agaro", origin: "Ethiopia", process: "Wet", roaster: passenger)
        
        return [comobiaSanRoque, geishaVillage, daterra, montecarlos, stowaway, agaro]
    }
    
}
