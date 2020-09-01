//
//  ListCampaignViewController.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class ListCampaignViewController: UIViewController {
  
  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureCollectionView()
    
    //    service.getFeed { result in
    //      switch result {
    //      case .success(let campaigns):
    //        print(campaigns)
    //      case .failure(let error):
    //        print(error)
    //      }
    //    }
  }
  
  func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    let width = self.view.bounds.width
    layout.itemSize = CGSize(width: width, height: 260)
    layout.scrollDirection = .vertical
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    view.addSubview(collectionView)
    collectionView.register(ListCampaignCell.self, forCellWithReuseIdentifier: "cellContainer")
    collectionView.dataSource = self
  }
}

extension ListCampaignViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContainer", for: indexPath) as! ListCampaignCell
    return cell
  }
  
  
}
