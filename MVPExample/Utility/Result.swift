//
//  Result.swift
//  MVPExample
//
//  Created by Kyle Kirkland on 4/17/19.
//  Copyright © 2019 Kirkland. All rights reserved.
//

import Foundation

enum Result<Value> {
    
    case success(Value)
    case error(Error)
    
}
