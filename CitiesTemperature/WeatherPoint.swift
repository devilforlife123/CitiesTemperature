//
//  WeatherPoint.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Coordinate{
    let longitude:Double
    let latitude:Double
}

class WeatherPoint{
    
    var temperature: Double
    var humidity: Double
    var pressure: Double
    var name: String
    var countryCode: String
    var coordinate:Coordinate
    
    init(temperature:Double,humidity:Double,pressure:Double,name:String,countryCode:String,coordinate:Coordinate){
        self.temperature = temperature
        self.humidity  = humidity
        self.pressure = pressure
        self.name = name
        self.countryCode = countryCode
        self.coordinate = coordinate
    }
    
    convenience init(dictionary:[String:AnyObject]){
        let json = JSON.init(dictionary)
        let name = json["name"].stringValue
        
        let sys = json["sys"].dictionaryValue
        let countryCode = sys["country"]?.stringValue
        let coordinateDict = json["coord"].dictionaryValue
        let latitude = coordinateDict["lat"]?.doubleValue
        let longitude = coordinateDict["lon"]?.doubleValue
        let coordinate = Coordinate(longitude: longitude!, latitude: latitude!)
        let main = json["main"].dictionaryValue
        let temperature = main["temp"]?.doubleValue
        let humidity = main["humidity"]?.doubleValue
        let pressure = main["pressure"]?.doubleValue
        
        self.init(temperature:temperature!,humidity:humidity!,pressure:pressure!,name:name,countryCode:countryCode!,coordinate:coordinate)
    }
    
    
    
}
