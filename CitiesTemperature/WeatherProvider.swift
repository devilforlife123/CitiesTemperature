//
//  PendingOperations.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//
import Foundation
import UIKit

class WeatherProvider{
    
    private let operationQueue = OperationQueue()
    let cityID:Int
    
    init(cityID:Int,completion:@escaping (WeatherPoint?)->()){
        self.cityID = cityID
        let fetchOperation = FetchOperation(cityID: cityID, completion: completion)
        operationQueue.addOperation(fetchOperation)
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}

extension WeatherProvider: Hashable {
    var hashValue: Int {
        return cityID.hashValue
    }
}

func ==(lhs: WeatherProvider, rhs: WeatherProvider) -> Bool {
    return lhs.cityID == rhs.cityID
}


