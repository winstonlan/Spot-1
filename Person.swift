//
//  Person.swift
//  Spot
//
//  Created by Winston Lan on 2/18/19.
//  Copyright © 2019 Winston Lan. All rights reserved.
//

import Foundation
import Firebase

struct Person {
    let key: String
    let name: String
    let amount: Double
    let ref: DatabaseReference?
    
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        amount = snapshotValue["amount"] as! Double
        ref = snapshot.ref
    }
    
    init(name: String, amount: Double, key: String = "") {
        self.key = key
        self.name = name
        self.amount = amount
        self.ref = nil
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "amount": amount
        ]
    }
}
