//
//  CoffeeCell.swift
//  MVPExample
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import Foundation
import UIKit

protocol CoffeeCellView {
    
    func displayCoffeeName(_ name: String)
    func dispalyCoffeeOrigin(_ origin: String)
    
}

final class CoffeeTableViewCell: UITableViewCell, CoffeeCellView {
    
    @IBOutlet var coffeeNameLabel: UILabel!
    @IBOutlet var coffeeOriginLabel: UILabel!
    
    func displayCoffeeName(_ name: String) {
        coffeeNameLabel.text = name
    }
    
    func dispalyCoffeeOrigin(_ origin: String) {
        coffeeOriginLabel.text = origin
    }
    
}
