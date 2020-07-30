//
//  WireWeatherResponse.swift
//  OfflineWeatherForecast
//
//  Created by jucollado on 7/29/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import Foundation

class WireWeatherResponse: Codable {
  var timezone: String
  var daily: [WireDailyForecast]
  
  init(timezone: String, daily: [WireDailyForecast]) {
    self.timezone = timezone
    self.daily = daily
  }
  
}
