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
    stack.distribution = .fillProportionally
    stack.isBaselineRelativeArrangement = true
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private var campaignImage: UIImageView = {
    let image = UIImage(named: "tiktok_icon")!
    
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.border(width: 1, color: UIColor.lightGray.withAlphaComponent(0.6))
    imageView.roundCorners(to: 6)
    
    return imageView
  }()
  
  private var campaignTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Yarn"
    label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)!
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private var campaignDescriptionLabel: UILabel = {
    let label = UILabel()
    let text = NSMutableAttributedString()
    
    text.append(
      NSAttributedString(
        string: "8.2",
        attributes: [
          .font: UIFont(name: "HelveticaNeue-Bold", size: 20)!,
          .foregroundColor: UIColor.systemGreen
        ]
      )
    )
    text.append(
      NSAttributedString(
        string: " per install",
        attributes: [
          .font: UIFont(name: "HelveticaNeue", size: 20)!,
          .foregroundColor: UIColor.systemGreen
        ]
      )
    )
    label.attributedText = text
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
    
    vStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    vStackView.isLayoutMarginsRelativeArrangement = true
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: hStackView.topAnchor),
      bottomAnchor.constraint(equalTo: hStackView.bottomAnchor),
      leadingAnchor.constraint(equalTo: hStackView.leadingAnchor),
      trailingAnchor.constraint(equalTo: hStackView.trailingAnchor),
      
      //1:1 Aspect ratio
      campaignImage.widthAnchor.constraint(equalTo: campaignImage.heightAnchor)
    ])
  }
}
