//
//  RemoteStorage.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 18.10.2020.
//

import Foundation

/// Loads data from API
class RemoteStorage {
  
  private let endpoints: [Country: Endpoint] = [
    
    .et: Endpoint(
      host: "www.swedbank.ee",
      path: "finder.json",
      httpHeaders: [
        .contentType(.applicationJson)
      ]),
    
    .lv: Endpoint(
      host: "ib.swedbank.lv",
      path: "finder.json",
      httpHeaders: [
        .contentType(.applicationJson)
      ]),
    
    .lt: Endpoint(
      host: "ib.swedbank.lt",
      path: "finder.json",
      httpHeaders: [
        .contentType(.applicationJson)
      ]),
  ]
  
  // MARK: - Properties
  
  private let dataLoader: RemoteDataLoadable
  private let dataTasksHolder: ThreadSafeDictionary<Country, DataTask>
  private let cookieStorage: CookieStorage
  
  // MARK: - Lifecycle
  
  init(
    dataLoader: RemoteDataLoadable = URLSession.shared,
    dataTasksHolder: ThreadSafeDictionary<Country, DataTask> = ThreadSafeDictionary(),
    cookieStorage: CookieStorage = HTTPCookieStorage.shared
  ) {
    self.dataLoader = dataLoader
    self.dataTasksHolder = dataTasksHolder
    self.cookieStorage = cookieStorage
  }
  
  // MARK: - Funcs
  
  private func makeCookieWith(
    name: String,
    value: String,
    url: URL
  ) -> HTTPCookie {
    
    guard let cookie = HTTPCookie(
      name: name,
      value: value,
      url: url
    ) else {
      fatalError("Failed to create HTTPCookie with [name: '\(name)', value: '\(value)', url: '\(url.absoluteString)']")
    }
    
    return cookie
  }
  
  private func setCookie(
    for url: URL,
    in cookieStorage: CookieStorage
  ) {

    let cookie = makeCookieWith(
      name: "Swedbank-Embedded",
      value: "iphone-app",
      url: url)
    
    cookieStorage.setCookie(cookie)
  }
  
}

// MARK: - BanksDataLoadable
extension RemoteStorage: BanksDataLoadable {
  
  func fetchBanksData(
    for country: Country,
    completion: @escaping (Result<Data, LoadingError>) -> Void
  ) {
    
    guard let endpoint = endpoints[country] else {
      fatalError("Failed to get Endpoint for country '\(country.rawValue)'")
    }
    
    let task = dataLoader.dataTask(with: endpoint.request) { data, _, error in
      
      if let error = error {
        completion(.failure(.system(error)))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      completion(.success(data))
    }
    
    setCookie(for: endpoint.url, in: cookieStorage)
 
    task.resume()
    
    dataTasksHolder.set(task, forKey: country)
  }
  
  func cancel(for country: Country) {
    
    dataTasksHolder.getValue(forKey: country) { dataTask in
      dataTask?.cancel()
    }
  }
}
