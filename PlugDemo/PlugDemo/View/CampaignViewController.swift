//
//  ViewController.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class CampaignViewController: UIViewController {
  
  let service: CampaignOperation = CampaignService()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let padding: CGFloat = 4
    layout.sectionInset = UIEdgeInsets(top: padding, left: padding , bottom: padding, right: padding)
    layout.itemSize = CGSize(width: 150, height: 250)
    layout.scrollDirection = .horizontal
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.backgroundColor = .brown
    return collection
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
//    service.getFeed { result in
//      switch result {
//      case .success(let campaigns):
//        print(campaigns)
//      case .failure(let error):
//        print(error)
//      }
//    }
    setConstraints()
    configureCollectionView()
  }

}

extension CampaignViewController {
  func setConstraints() {
    view.addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor),
      self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
      self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
      
      collectionView.heightAnchor.constraint(equalToConstant: 260)
    ])
  }
  
  func configureCollectionView() {
    collectionView.dataSource = self
    collectionView.register(CampaignCell.self, forCellWithReuseIdentifier: "cell")
  }
}

extension CampaignViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CampaignCell
    return cell
  }
  
  
}

