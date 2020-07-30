//
//  WireDailyForecast.swift
//  OfflineWeatherForecast
//
//  Created by jucollado on 7/29/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import Foundation

class WireDailyForecast: Codable {
  
  var date: Int
  var weather: [WireWeather]
  
  init(date: Int, weather: [WireWeather]) {
    self.date = date
    self.weather = weather
  }
  
  enum CodingKeys: String, CodingKey {
    case date = "dt"
    case weather
  }
  
}
