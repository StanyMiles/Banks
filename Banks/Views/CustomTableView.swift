//
//  CustomTableView.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import UIKit

final class CustomTableView: UITableView {
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) is not supported. Initialize CustomTableView programmatically")
  }
  
  // MARK: - Funcs
  
  private func setupView() {
    
    backgroundColor = .systemGray5
    
    // To hide unnecessary separators
    tableFooterView = UIView()
  }
}
