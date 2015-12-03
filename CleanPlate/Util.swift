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
    var restaurantHours:String = ""
    var restaurantAddr:String = ""
    var restaurantNames = ["Scoop", "Cheesecake Factory", "Zola", "In-n-Out", "Tacolicious"]
    var rewardDescriptions = ["Free Single Scoop Cone", "Free Dessert with Meal", "50% off wine pairing", "Free fries", "Free taco"]
    var rewardImages = ["scoop","cheesecake-factory-logo","zola-logo","in-n-out-logo", "tacoliciousicon"]
    
    var favImages = ["scoop","cheesecake-factory-logo","zola-logo","in-n-out-logo", "tacoliciousicon"]
    
    var favRestaurantNames = ["Scoop", "Cheesecake Factory", "Zola", "In-n-Out", "Tacolicious"]
    
    var redeemedNames = [String]()
    var redeemedDescriptions = [String]()
    var redeemedImages = [String]()
    
    func getRestaurantAddr()->String{
        return restaurantAddr
    }
    
    func setRestaurantAddr(addr:String){
        restaurantAddr = addr
    }
    
    func getFavImages()->[String]{
        return favImages
    }
    
    func getFavRestaurantNames() -> [String]{
        return favRestaurantNames
    }
    
    func setFavRestaurantNames(names:[String]){
        favRestaurantNames = names
    }
    
    func setFavImages(images: [String]){
        favImages = images
    }
    func getRestaurantHours() -> String{
        return restaurantHours
    }
    
    func setRestaurantHours(hours: String) {
        restaurantHours = hours
    }
    
    func getRewardActiveRestaurantNames() -> [String]{
        return restaurantNames
    }
    
    func getRewardActiveDescriptions() -> [String]{
        return rewardDescriptions
    }
    
    func getRewardActiveImages() -> [String]{
        return rewardImages
    }
    
    func getRedeemedImages() ->[String]{
        return redeemedImages
    }
    
    func getRedeemedNames() -> [String]{
        return redeemedNames
    }
    
    func getRedeemedDescriptions() -> [String]{
        return redeemedDescriptions
    }
    
    func setRedeemedNames(names: [String]){
        redeemedNames = names
    }
    
    func setRewardActiveRestaurantNames(names: [String]){
        restaurantNames = names
    }
    
    func setRewardActiveDescriptions(names: [String]){
        rewardDescriptions = names
    }
    
    func setRedeemedDescriptions(names: [String]){
        redeemedDescriptions = names
    }
    
    func setRewardActiveImages(names: [String]){
        rewardImages = names
    }
    
    func setRedeemedImages(names: [String]){
        redeemedImages = names
    }
    
    
    
    
    
    
    
    
    
    
    func getRestaurantName() -> String{
        return restaurantName
    }
    
    
    func setRestaurantName(name: String){
        restaurantName = name
    }
}