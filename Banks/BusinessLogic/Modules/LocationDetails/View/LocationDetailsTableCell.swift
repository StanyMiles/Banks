//
//  LocationDetailsTableCell.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 28.10.2020.
//

import UIKit

final class LocationDetailsTableCell: UITableViewCell {
  
  static let cellID = "CellID"
  
  // MARK: - Views
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.textColor = .systemGray2
    label.font = .preferredFont(forTextStyle: .footnote)
    return label
  }()
  
  private lazy var valueLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 0
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented. Initialize LocationDetailTableCell programmatically")
  }

  // MARK: - Funcs
 
  func setup(with details: (name: String, value: String)) {
    nameLabel.text = details.name.uppercased()
    valueLabel.text = details.value
  }
  
  private func setupViews() {
    
    addSubview(valueLabel)
    addSubview(nameLabel)
    
    valueLabel.fillSuperview(
      padding: .init(
        top: 10,
        left: frame.width * 0.4,
        bottom: 10,
        right: 20))
    
    nameLabel.anchor(
      leading: leadingAnchor,
      bottom: valueLabel.bottomAnchor,
      trailing: valueLabel.leadingAnchor,
      padding: .init(
        top: 0,
        left: 20,
        bottom: 0,
        right: 10))
  }
}
