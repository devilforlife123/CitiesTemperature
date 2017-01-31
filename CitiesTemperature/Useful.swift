//
//  Useful.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import Foundation


enum OpenWeatherConstants{
    static let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/"
    static let openWeatherMapApiKey = "9be728a0b3ed79c4ce3ff39d979af16a"
}

class FormatHelper{
    
    class func formatNumber(_ number: Double, withFractionDigitCount fractionDigitCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = fractionDigitCount
        numberFormatter.minimumFractionDigits = fractionDigitCount
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}

