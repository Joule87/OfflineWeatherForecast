//
//  NetworkingService.swift
//  OfflineWeatherForecast
//
//  Created by jucollado on 7/29/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import Foundation

enum NetworkingService {
  
  static func requestDailyForecast(completion: @escaping (Result<WireWeatherResponse, Error>) -> Void) {
    let urlString = "http://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&%20&exclude=current,minutely,hourly&appid=d452f6bce6ef6c3ae58df1af769bc4c7"
    let url = URL(string: urlString)!
    let task = URLSession.shared.dataTask(with: url) {
      if let error = $2 {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      } else if let data = $0, let dailyForecast = try? JSONDecoder().decode(WireWeatherResponse.self, from: data) {
        DispatchQueue.main.async {
          completion(.success(dailyForecast))
        }
      }
    }
    task.resume()
  }
}
