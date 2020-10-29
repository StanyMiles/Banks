//
//  HTTPCookie+Ext.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 29.10.2020.
//

import Foundation

extension HTTPCookie {
  
  convenience init?(name: String, value: String, url: URL) {
    self.init(properties: [
      .name: name,
      .value: value,
      .domain: url.absoluteString,
      .path: "/",
    ])
  }
}
