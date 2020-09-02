//
//  CampaignCell.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class CampaignCell: UICollectionViewCell {
  private var vStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 4
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private var hStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.backgroundColor = .white
    stack.border(width: 1, color: UIColor.lightGray.withAlphaComponent(0.6))
    stack.roundCorners(to: 6)
    return stack
  }()
  
  var mediaView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    view.border(width: 1, color: UIColor.lightGray.withAlphaComponent(0.6))
    view.roundCorners(to: 6)
    return view
  }()
  
  var trackingLinkView: UIView {
    let view = TrackingLinkView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.border(width: 0.5, color: UIColor.lightGray.withAlphaComponent(0.6))
    return view
  }
  
  var downloadView: UIView {
    let view = DownloadView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.border(width: 0.5, color: UIColor.lightGray.withAlphaComponent(0.6))
    return view
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension CampaignCell {
  func setConstraints() {
    addSubview(vStackView)
    vStackView.addArrangedSubview(mediaView)
    vStackView.addArrangedSubview(hStackView)
    hStackView.addArrangedSubview(trackingLinkView)
    hStackView.addArrangedSubview(downloadView)

    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: vStackView.topAnchor),
      bottomAnchor.constraint(equalTo: vStackView.bottomAnchor),
      leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
      trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),
      
      vStackView.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor),
      hStackView.heightAnchor.constraint(equalToConstant: 50),
      
      vStackView.topAnchor.constraint(equalTo: mediaView.topAnchor),
      vStackView.leadingAnchor.constraint(equalTo: mediaView.leadingAnchor),
      vStackView.trailingAnchor.constraint(equalTo: mediaView.trailingAnchor),
    ])
  }
}
