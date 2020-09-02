//
//  CampaignHeaderView.swift
//  PlugDemo
//
//  Created by projas on 9/1/20.
//

import UIKit

class CampaignHeaderView: UIView {
  private var hStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fillProportionally
    stack.spacing = 4
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private var vStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 4
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private var campaignImage: UIImageView = {
    let image = UIImage(systemName: "star.fill")!
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  private var campaignTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Yarn"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private var campaignDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "8.2 per install"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView() {
    addSubview(hStackView)
    hStackView.addArrangedSubview(campaignImage)
    hStackView.addArrangedSubview(vStackView)
    vStackView.addArrangedSubview(campaignTitleLabel)
    vStackView.addArrangedSubview(campaignDescriptionLabel)
    
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: hStackView.topAnchor),
      bottomAnchor.constraint(equalTo: hStackView.bottomAnchor),
      leadingAnchor.constraint(equalTo: hStackView.leadingAnchor),
      trailingAnchor.constraint(equalTo: hStackView.trailingAnchor),
      
      campaignImage.widthAnchor.constraint(equalTo: campaignImage.heightAnchor)
    ])
  }
}
