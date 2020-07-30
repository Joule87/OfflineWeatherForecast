//
//  MemoryCachingManager.swift
//  OfflineWeatherForecast
//
//  Created by jucollado on 7/30/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import Foundation

class MemoryCachingManager {
  
  private let objectCache = NSCache<NSString, AnyObject>()
  private var observer: ((_ item: AnyObject?) -> Void)?
  static let shared = MemoryCachingManager()
  
  private init() {}
  
  public func setObserver(key: NSString, _ inObserver: @escaping (_ item: AnyObject?) -> Void) {
    observer = inObserver
    let item = objectCache.object(forKey: key)
    observer?(item)
  }
  
  public func cleanObserver() {
    observer = nil
  }
  
  public func cache(item: AnyObject, for key: NSString) {
    objectCache.setObject(item, forKey: key)
    observer?(item)
  }
}
