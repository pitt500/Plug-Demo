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
  let transition = PopAnimator()
  weak var selectedCell: CampaignCell?
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
  func didTapMedia(_ media: Media, selectedCell: CampaignCell) {
    self.selectedCell = selectedCell
    let vc = CampaignMediaDetailViewController(media: media)
    vc.modalPresentationStyle = .fullScreen
    vc.transitioningDelegate = self
    present(vc, animated: true, completion: nil)
  }
}

extension ListCampaignViewController: UIViewControllerTransitioningDelegate {
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    
    guard
      let selectedCell = self.selectedCell,
      let selectedCellSuperView = selectedCell.superview
    else {
      return nil
    }
    

    transition.originFrame = selectedCellSuperView.convert(selectedCell.frame, to: nil)
    transition.originFrame = CGRect(
      x: transition.originFrame.origin.x,
      y: transition.originFrame.origin.y,
      width: transition.originFrame.size.width,
      height: transition.originFrame.size.height - 40
    )

    transition.presenting = true
    
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}
