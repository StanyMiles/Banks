//
//  CountryHeaderView.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 19.10.2020.
//

import UIKit

final class CountryHeaderView: UIView {
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Funcs
  
  private func setupViews() {
    
    backgroundColor = .systemGray6
    
    addSubview(titleLabel)
    titleLabel.fillSuperview(
      padding: .init(
        top: 0,
        left: 20,
        bottom: 0,
        right: 0))
  }
}
