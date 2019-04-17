//
//  MVPExampleTests.swift
//  MVPExampleTests
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import XCTest
@testable import MVPExample

class MVPExampleTests: XCTestCase {

    let coffeeListSpy = CoffeeListViewSpy()
    let coffeeServiceStub = CoffeeServiceStub()
    var coffeePresenter: CoffeeListPresenterImplementation!
    
    override func setUp() {
        super.setUp()
       
        coffeePresenter = CoffeeListPresenterImplementation(view: coffeeListSpy, service: coffeeServiceStub)
    }
    
    func test_viewDidLoad_CallsStartLoading() {
        // Given
        
        // When
        coffeePresenter.viewDidLoad()
        
        //Then
        XCTAssertTrue(coffeeListSpy.startLoadingCalled)
    }
    
    func test_viewDidLoad_DispalyCoffee_CalledOnSuccessfulLoad() {
        let coffee = Coffee(name: "test", origin: "test", process: "test", roaster: Roaster(name: "Roaster", location: "test"))
        coffeeServiceStub.resultToBeReturned = .success([coffee])
        
        coffeePresenter.viewDidLoad()
        
       XCTAssertTrue(coffeeListSpy.displayCoffeeCalled)
    }
    
    func test_didSelectRow_CallsDisplayRoaster() {
        // Given
        let coffee = Coffee(name: "test", origin: "test", process: "test", roaster: Roaster(name: "Roaster", location: "test"))
        coffeePresenter.coffees = [coffee]
        
        // When
        coffeePresenter.didSelectRow(at: 0)
        
        // Then
        XCTAssertTrue(coffeeListSpy.displayRoasterCalled)
        XCTAssertEqual(coffeeListSpy.roastersName, "Roaster")
    }

}
