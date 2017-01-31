//
//  CityCell.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import Foundation
import UIKit

class CityCell:UITableViewCell{
    
    @IBOutlet weak var cityLabel:UILabel!
    @IBOutlet weak var temperatureLabel:UILabel!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var cityID:Int?{
        didSet{
            
        }
    }
    func updateCellWithWeatherInfo(_ weatherPoint:WeatherPoint?){
        if let weatherPoint = weatherPoint{
            cityLabel.text = weatherPoint.name
            temperatureLabel.text = String(weatherPoint.temperature)
            UIView.animate(withDuration: 0.3, animations: {
                self.activityIndicator.alpha = 0
            }, completion: {
                _ in
                self.activityIndicator.stopAnimating()
            })
        }else {
            cityLabel.text = "City"
            temperatureLabel.text = "0.0"
            activityIndicator.alpha = 1.0
            activityIndicator.startAnimating()
        }

    }
    
    
    
    
}
