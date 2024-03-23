//
//  Model.swift
//  upstoxHolding
//
//  Created by Vaibhav Bisht on 22/03/24.
//

import Foundation

struct UserHolding: Codable {
    let userHolding : [Equity]
}

struct Equity: Codable, Hashable{
    let symbol: String?
    let quantity: Int?
    let ltp: Float?
    let avgPrice: Float?
    let close : Float?
    
}
