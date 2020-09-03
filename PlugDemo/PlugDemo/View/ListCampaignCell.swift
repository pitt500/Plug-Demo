//
//  ListCampaignCell.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class ListCampaignCell: UICollectionViewCell {
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let padding: CGFloat = 4
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding , bottom: padding, right: padding)
    layout.itemSize = CGSize(width: 150, height: 250)
    layout.scrollDirection = .horizontal
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.backgroundColor = .white
    collection.translatesAutoresizingMaskIntoConstraints = false
    return collection
  }()
  
  let headerView: CampaignHeaderView = {
    let view = CampaignHeaderView()

    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var media: [Media] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setConstraints()
    configureCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with campaign: Campaign) {
    headerView.campaignTitleLabel.text = campaign.campaignName
    headerView.campaignDescriptionLabel.attributedText = setCampaignDescription(campaign)
    self.media = campaign.medias
    
    CampaignService.shared.downloadImage(from: campaign.campaignIconUrl, completion: { [weak self] image in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.headerView.campaignImage.image = image
      }
    })
  }
  
  private func setCampaignDescription(_ campaign: Campaign) -> NSAttributedString {
    let text = NSMutableAttributedString()
    
    text.append(
      NSAttributedString(
        string: campaign.payPerInstall,
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

    return text
  }
}

extension ListCampaignCell {
  func setConstraints() {
    addSubview(headerView)
    addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      safeAreaLayoutGuide.topAnchor.constraint(equalTo: headerView.topAnchor),
      safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: -4),
      safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 4),
      headerView.heightAnchor.constraint(equalToConstant: 100),
      
      collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
      safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
      
      collectionView.heightAnchor.constraint(equalToConstant: 260)
    ])
  }
  
  func configureCollectionView() {
    collectionView.dataSource = self
    collectionView.register(CampaignCell.self, forCellWithReuseIdentifier: "cell")
  }
}

extension ListCampaignCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return media.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CampaignCell
    cell.configure(with: media[indexPath.row])
    return cell
  }
  
  
}
