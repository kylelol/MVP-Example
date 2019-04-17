//
//  ViewController.swift
//  MVPExample
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import UIKit

class CoffeeListController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var loadingView: UIView!
    
    private var coffees: [Coffee] = []
    
}

// MARK: - UIViewController Lifecycle

extension CoffeeListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        displayLoading(isVisible: true)
        CoffeeService.fetchAvailableCoffees { [unowned self] result in
            switch result {
            case .success(let coffees):
                self.coffees = coffees
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
            self.displayLoading(isVisible: false)
        }
    }
    
}

// MARK: - Helpers

private extension CoffeeListController {
    
    func displayLoading(isVisible: Bool) {
        func animations() {
            loadingView.alpha = isVisible ? 1.0 : 0.0
            tableView.alpha = isVisible ? 0.0 : 1.0
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                animations()
            },
            completion: nil
        )
    }
    
    func displayRoaster(for coffee: Coffee) {
        let alert = UIAlertController(title: "Roaster", message: coffee.roaster.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension CoffeeListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coffeeCell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell") as? CoffeeTableViewCell else {
            preconditionFailure("We must have a coffee cell to continue")
        }
        
        let coffee = coffees[indexPath.row]
        coffeeCell.coffeeNameLabel.text = coffee.name
        coffeeCell.coffeeOriginLabel.text = coffee.origin
        
        return coffeeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

extension CoffeeListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCoffee = coffees[indexPath.row]
        displayRoaster(for: selectedCoffee)
    }
    
}

