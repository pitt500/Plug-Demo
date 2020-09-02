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
    collection.backgroundColor = .brown
    collection.translatesAutoresizingMaskIntoConstraints = false
    return collection
  }()
  
  let headerView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setConstraints()
    configureCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension ListCampaignCell {
  func setConstraints() {
    addSubview(headerView)
    addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      safeAreaLayoutGuide.topAnchor.constraint(equalTo: headerView.topAnchor),
      safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
      safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
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
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CampaignCell
    return cell
  }
  
  
}
