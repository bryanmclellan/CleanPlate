//
//  Util.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 12/2/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import Foundation

class Util {
    static let sharedInstance = Util()
    
    var restaurantName:String  = ""
    
    func getRestaurantName() -> String{
        return restaurantName
    }
    
    func setRestaurantName(name: String){
        restaurantName = name
    }
}