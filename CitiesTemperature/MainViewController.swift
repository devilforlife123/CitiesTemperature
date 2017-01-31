//
//  MainViewController.swift
//  OptusTest
//
//  Created by suraj poudel on 30/1/17.
//  Copyright © 2017 pyroTech Ltd. All rights reserved.
//

import Foundation
import UIKit


class MainViewController:UITableViewController{
    
    var cityDictionary:[String:Int] = ["Sydney":2147714, "Melbourne":2158177, "Brisbane":2174003]
    var weatherProviders = Set<WeatherProvider>()
    var weatherPoints:[WeatherPoint?] = Array(repeating: nil, count: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityDictionary.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Locations", for: indexPath)
        
        if let cell = cell as? CityCell{
            cell.cityID = (Array(cityDictionary.values)[indexPath.row])
        }
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            let modalStyle:UIModalTransitionStyle = .crossDissolve
            let weatherPoint = weatherPoints[indexPath.row];
            detailViewController.modalTransitionStyle = modalStyle
            detailViewController.modalPresentationStyle = .custom
            detailViewController.weatherData = weatherPoint
        }
    }
}
extension MainViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CityCell else { return }
        
        let weatherProvider = WeatherProvider(cityID: (Array(cityDictionary.values)[indexPath.row])){ (weatherPoint) in
            OperationQueue.main.addOperation({
                var indexPath = tableView.indexPath(for: cell)!
                if(indexPath.row < self.weatherPoints.count){
                   self.weatherPoints[indexPath.row] = weatherPoint
                }
                cell.updateCellWithWeatherInfo(weatherPoint)
            })
        }
        
        weatherProviders.insert(weatherProvider)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CityCell else { return }
        for provider in weatherProviders.filter({ $0.cityID == cell.cityID }) {
            provider.cancel()
            weatherProviders.remove(provider)
        }
    }
}

