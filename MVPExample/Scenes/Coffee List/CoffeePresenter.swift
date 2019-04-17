//
//  CoffeePresenter.swift
//  MVPExample
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import Foundation

protocol CoffeeListView: class {
   
    func startLoading()
    func displayCoffees()
    func displayError(_ error: Error)
    func displayRoaster(_ roaster: Roaster)
    
}

protocol CoffeeListPresenter {
    
    func viewDidLoad()
    func didSelectRow(at index: Int)
    func configure(cell: CoffeeCellView, for row: Int)
    func rowCount() -> Int
    
}

final class CoffeeListPresenterImplementation: CoffeeListPresenter {
    
    weak var view: CoffeeListView?
    
    var coffees: [Coffee] = []
    
    init(view: CoffeeListView?) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.startLoading()
        CoffeeService.fetchAvailableCoffees { [unowned self] result in
            switch result {
            case .success(let coffees):
                self.coffees = coffees
                self.view?.displayCoffees()
            case .error(let error):
                self.view?.displayError(error)
            }
        }
    }
    
    func didSelectRow(at index: Int) {
        let selectedCoffee = coffees[index]
        view?.displayRoaster(selectedCoffee.roaster)
    }
    
    func rowCount() -> Int {
        return coffees.count
    }
    
    func configure(cell: CoffeeCellView, for row: Int) {
        let coffee = coffees[row]
        cell.displayCoffeeName(coffee.name)
        cell.dispalyCoffeeOrigin(coffee.origin ?? "No Origin")
    }
    
}
