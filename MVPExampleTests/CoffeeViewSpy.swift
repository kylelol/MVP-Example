//
//  CoffeeViewSpy.swift
//  MVPExampleTests
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

@testable import MVPExample
import Foundation

class CoffeeListViewSpy: CoffeeListView {
    
    var startLoadingCalled = false
    var displayRoasterCalled = false
    var displayCoffeeCalled = false
    var roastersName = ""
    
    func startLoading() {
        startLoadingCalled = true
    }
    
    func displayCoffees() {
        displayCoffeeCalled = true
    }
    
    func displayError(_ error: Error) {
        
    }
    
    func displayRoaster(_ roaster: Roaster) {
        displayRoasterCalled = true
        roastersName = roaster.name
    }
    
}
