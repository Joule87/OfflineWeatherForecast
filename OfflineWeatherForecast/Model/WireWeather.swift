//
//  WireWeather.swift
//  OfflineWeatherForecast
//
//  Created by jucollado on 7/29/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import Foundation

class WireWeather: Codable {
  
  var id: Int
  var main: String
  var description: String
  
  init(id: Int, main: String, description: String) {
    self.id = id
    self.main = main
    self.description = description
  }
  
}
