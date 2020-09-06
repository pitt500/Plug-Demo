//
//  ListCampaignViewController.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class ListCampaignViewController: UIViewController {
  
  var collectionView: UICollectionView!
  var service: CampaignOperation = CampaignService()
  var campaigns: [Campaign] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "PLUGS"
    navigationController?.navigationBar.prefersLargeTitles = true
    configureCollectionView()
    fillContent()
  }
  
  func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    let width = self.view.bounds.width
    layout.itemSize = CGSize(width: width, height: 370)
    layout.scrollDirection = .vertical
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(ListCampaignCell.self, forCellWithReuseIdentifier: "cellContainer")
    collectionView.dataSource = self
  }
  
  func fillContent() {
    service.getFeed { result in
      
      DispatchQueue.main.async {
        switch result {
        case .success(let campaigns):
          self.campaigns = campaigns
        case .failure(let error):
          print(error.localizedDescription)
          let alert = UIAlertController(title: "Error", message: "Unable to load data", preferredStyle: .alert)
          self.present(alert, animated: true, completion: nil)
        }
      }
    }
  }
}

extension ListCampaignViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return campaigns.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContainer", for: indexPath) as! ListCampaignCell
    cell.configure(with: campaigns[indexPath.row], delegate: self)
    return cell
  }
}

extension ListCampaignViewController: CampaignInteraction {
  func didTapMedia(_ media: Media) {
    let vc = CampaignMediaDetailViewController(media: media)
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
  }
}
