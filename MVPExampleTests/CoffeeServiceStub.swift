//
//  CoffeeServiceStub.swift
//  MVPExampleTests
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import Foundation
@testable import MVPExample

class CoffeeServiceStub: CoffeeService {
    
    var resultToBeReturned: Result<[Coffee]> = .success([])
    
    func fetchAvailableCoffees(response: @escaping (Result<[Coffee]>) -> Void) {
        response(resultToBeReturned)
    }
    
}
