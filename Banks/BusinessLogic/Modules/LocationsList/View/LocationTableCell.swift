//
//  LocationTableCell.swift
//  Banks
//
//  Created by Stanislav Kobiletski on 23.10.2020.
//

import UIKit

class LocationTableCell: UITableViewCell {
  
  static let cellID = "CellID"
  
  // MARK: - Views
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()
  
  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .subheadline)
    return label
  }()
  
  private lazy var typeLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.textColor = .white
    label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    label.textAlignment = .center
    label.layer.masksToBounds = true
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  // MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented. Initialize LocationTableCell programmatically")
  }
  
  // MARK: - Funcs
  
  func setup(
    with location: BankLocation,
    uiManager: CellUIManager
  ) {
    
    titleLabel.text = location.name
    subtitleLabel.text = location.address
    
    typeLabel.text = location.type.symbol
    typeLabel.backgroundColor = uiManager.getColor(for: location.type)
  }
  
  private func setupViews() {
    
    let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stack.axis = .vertical
    stack.spacing = 4
    stack.alignment = .leading
    
    addSubview(typeLabel)
    addSubview(stack)
    
    let typeSide: CGFloat = 50
    typeLabel.anchor(
      leading: leadingAnchor,
      padding: .init(
        top: 0,
        left: 20,
        bottom: 0,
        right: 0),
      size: .init(
        width: typeSide,
        height: typeSide))
    
    typeLabel.centerYAnchor
      .constraint(equalTo: centerYAnchor)
      .isActive = true
 
    typeLabel.layer.cornerRadius = typeSide / 2
    
    stack.anchor(
      top: topAnchor,
      leading: typeLabel.trailingAnchor,
      bottom: bottomAnchor,
      trailing: trailingAnchor,
      padding: .init(
        top: 20,
        left: 20,
        bottom: 20,
        right: 40))
    
    accessoryType = .disclosureIndicator
  }
  
}
