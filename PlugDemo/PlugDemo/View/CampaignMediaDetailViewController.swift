//
//  CampaignMediaDetailViewController.swift
//  PlugDemo
//
//  Created by projas on 9/3/20.
//

import UIKit

class CampaignMediaDetailViewController: UIViewController {
  var media: Media!
  
  var label: UILabel = {
    let l = UILabel()
    l.numberOfLines = 0
    l.translatesAutoresizingMaskIntoConstraints = false
    return l
  }()
  
  init(media: Media) {
    super.init(nibName: nil, bundle: nil)
    self.media = media
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureLabel()
    label.text = media.downloadUrl
  }
  
  func configureLabel() {
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      view.centerYAnchor.constraint(equalTo: label.centerYAnchor),
      view.centerXAnchor.constraint(equalTo: label.centerXAnchor),
      
      label.heightAnchor.constraint(equalToConstant: 300),
      label.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
}
