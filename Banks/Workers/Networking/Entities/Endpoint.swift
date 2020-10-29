//
//  Endpoint.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 29.10.2020.
//

import Foundation

struct Endpoint {
  var scheme: HTTPScheme = .https
  let host: String
  let path: String
  var httpMethod: HTTPMethod = .get
  let httpHeaders: [HTTPHeader]
}

extension Endpoint {
  
  var url: URL {
    
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host
    components.path = "/" + path
    
    guard let url = components.url else {
      preconditionFailure("Invalid URL components: \(components)")
    }
    
    return url
  }
  
  var request: URLRequest {
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue.uppercased()
    
    for header in httpHeaders {
      request.addHeader(header)
    }
    
    return request
  }
  
}
