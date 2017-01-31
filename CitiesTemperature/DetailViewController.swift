//
//  ViewController.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController{
    
    @IBOutlet weak  var cityNameLabel: UILabel!
    @IBOutlet weak  var countryNameLabel: UILabel!
    @IBOutlet weak  var temperatureLabel: UILabel!
    @IBOutlet weak  var humidityLabel: UILabel!
    @IBOutlet weak  var pressureLabel: UILabel!
    @IBOutlet weak  var latitudeLabel: UILabel!
    @IBOutlet weak  var longitudeLabel: UILabel!
    @IBOutlet weak  var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak  var mainStackView: UIStackView!
    @IBOutlet weak  var loadingStackView: UIStackView!
    @IBOutlet weak  var countdownLabelStackView: UIStackView!
    @IBOutlet weak  var countdownLabel: UILabel!
    
    var weatherData:WeatherPoint!{
        didSet{
            if isViewLoaded{
                updateLabels()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    func updateLabels(){
        let unitAbbreviation = "C"
        
        let countryNameText: String
        if let countryName = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: weatherData.countryCode){
            countryNameText = countryName.uppercased()
        }else if weatherData.countryCode == "none" {
            countryNameText = ""
        } else {
            countryNameText = weatherData.countryCode
        }
        countryNameLabel.attributedText = NSAttributedString(string: countryNameText, attributes: [NSKernAttributeName: 2])
        cityNameLabel.attributedText = NSAttributedString(string: weatherData.name.uppercased(), attributes: [NSKernAttributeName: 4])
        temperatureLabel.text = "\(weatherData.temperature)°\(unitAbbreviation)"
        humidityLabel.text = "\(weatherData.humidity) %"
        pressureLabel.text = "\(weatherData.pressure) hPa"
        
        latitudeLabel.text = FormatHelper.formatNumber(weatherData.coordinate.latitude, withFractionDigitCount: 2)
        longitudeLabel.text = FormatHelper.formatNumber(weatherData.coordinate.longitude, withFractionDigitCount: 2)
        
    }
    
    @IBAction func close(){
        
        dismiss(animated: false, completion: nil)
        
    }
}
extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


