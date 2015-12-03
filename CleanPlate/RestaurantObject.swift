//
//  RestaurantObject.swift
//  CleanPlate
//
//  Created by Bryan McLellan on 12/3/15.
//  Copyright © 2015 CleanPlate. All rights reserved.
//

import Foundation

class RestaurantObject: NSObject {
    var name:String
    var hours:String
    var address:String
    var discount:String
    var descrip:String
    
    init(resName: String, myHours: String, myAddress: String, myDiscount:String, myDescription: String ) {
        name = resName
        hours = myHours
        address = myAddress
        discount = myDiscount
        descrip = myDescription
    }
    
    
}