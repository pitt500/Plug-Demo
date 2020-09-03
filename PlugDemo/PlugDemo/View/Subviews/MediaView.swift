//
//  MediaView.swift
//  PlugDemo
//
//  Created by projas on 9/2/20.
//

import UIKit

class MediaView: UIView {
  var imageView: UIImageView = {
    let image = UIImage(named: "imagePlaceholder")!
    
    let view = UIImageView(image: image)
    view.contentMode = .center
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var playerButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  var playerImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(systemName: "play.fill")
    view.contentMode = .scaleAspectFit
    view.tintColor = .white
    view.isHidden = true
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
    addSubview(playerImageView)
    addSubview(playerButton)
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: imageView.topAnchor),
      bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
      
      centerYAnchor.constraint(equalTo: playerImageView.centerYAnchor),
      centerXAnchor.constraint(equalTo: playerImageView.centerXAnchor),
      playerImageView.heightAnchor.constraint(equalTo: playerImageView.widthAnchor),
      playerImageView.widthAnchor.constraint(equalToConstant: 40),
      
      playerButton.topAnchor.constraint(equalTo: playerImageView.topAnchor),
      playerButton.leadingAnchor.constraint(equalTo: playerImageView.leadingAnchor),
      playerButton.trailingAnchor.constraint(equalTo: playerImageView.trailingAnchor),
      playerButton.bottomAnchor.constraint(equalTo: playerImageView.bottomAnchor),
      
    ])
  }
}
