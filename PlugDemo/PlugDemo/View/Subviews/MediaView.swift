//
//  MediaView.swift
//  PlugDemo
//
//  Created by projas on 9/2/20.
//

import UIKit

class MediaView: UIView {
  var imageView: UIImageView = {
    let image = UIImage(named: "tiktok_demo")!
    
    let view = UIImageView(image: image)
    view.contentMode = .center
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureView() {
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: imageView.topAnchor),
      bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
    ])
  }
}
