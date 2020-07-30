//
//  ViewController.swift
//  OfflineWeatherForecast
//
//  Created by jucollado on 7/29/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
  
  @IBOutlet weak var dailyForecastTableView: UITableView!
  
  private var dailyForecast: [WireDailyForecast]?
  let refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    addRefreshControl()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    requestDailyForecast()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    MemoryCachingManager.shared.cleanObserver()
  }
  
  func addRefreshControl() {
    refreshControl.addTarget(self, action: #selector(requestDailyForecast), for: .valueChanged)
    dailyForecastTableView.refreshControl = refreshControl
  }
  
  @objc func requestDailyForecast() {
    let cacheKey: NSString = "DailyForecast"
    MemoryCachingManager.shared.setObserver(key: cacheKey) { item in
      //causes reload of all data from cache!!!
      //This might not be good in case of large amount of data!!!
      guard let item = item as? WireWeatherResponse else { print("No cached Item"); return }
      print("Got cached Item")
      self.dailyForecast = item.daily
      self.dailyForecastTableView.reloadData()
      self.dailyForecastTableView.refreshControl?.endRefreshing()
    }
    
    NetworkingService.requestDailyForecast { (result) in
      switch result {
      case .success(let response):
        print("Got network response for timezone: \(response.timezone)")
        MemoryCachingManager.shared.cache(item: response, for: cacheKey)
      case .failure(let error):
        print("\(error.localizedDescription)")
      }
    }
  }
  
}

extension WeatherForecastViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dailyForecast?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "WetherTableViewCell", for: indexPath) as! WetherTableViewCell
    
    let timestamp = Double(dailyForecast![indexPath.row].date)
    let date = Date(timeIntervalSince1970: timestamp)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.none
    dateFormatter.dateStyle = DateFormatter.Style.medium
    dateFormatter.timeZone = .current
    let formatteDate = dateFormatter.string(from: date)
    
    cell.dateLabel.text = "\(formatteDate)"
    cell.weatherLabel.text = dailyForecast?[indexPath.row].weather.first?.description
    return cell
  }
  
  
}

