//
//  DataProvider.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import SwiftyJSON

class DataProvider{
    
    var placeTask:URLSessionDataTask?
    var session:URLSession {
        return URLSession.shared
    }
    
    func fetchWeatherForCoordinate(_ locationID:Int,completion:@escaping(WeatherPoint?,Error?)->())
    {
        
        var apiEndpointPath = OpenWeatherConstants.openWeatherMapBaseURL
        apiEndpointPath += "weather?id=\(locationID)&units=metric"
        
        apiEndpointPath += "&APPID=\(OpenWeatherConstants.openWeatherMapApiKey)"
        
        if let task = placeTask , task.taskIdentifier > 0 && task.state == .running{
            task.cancel()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = URL(string: apiEndpointPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        placeTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error as? NSError, error.code == -999 {
                completion(nil,error)
                return
            }
            if let aData = data{
                let json = JSON.init(data: aData, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
                //print("Weather json is \(json)")
                let weatherPoint = WeatherPoint(dictionary:json.dictionaryObject as! [String : AnyObject])
                completion(weatherPoint,nil)
                
            }
        })
        
        placeTask?.resume()
    }

}
