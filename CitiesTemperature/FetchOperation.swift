//
//  FetchOperation.swift
//  OptusTest
//
//  Created by suraj poudel on 31/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import Foundation

class FetchOperation:Operation{
    
    private let cityID:Int
    private let completion: ((WeatherPoint?) -> ())?

    init(cityID:Int,completion:((WeatherPoint?)->())? = nil){
        self.cityID = cityID
        self.completion = completion
        super.init()
    }
    
    override func main() {
        DataProvider().fetchWeatherForCoordinate(self.cityID) { (weatherPoint, error) in
            self.completion?(weatherPoint)
        }
        
    }
}
