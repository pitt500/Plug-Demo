//
//  DownloadView.swift
//  PlugDemo
//
//  Created by projas on 9/1/20.
//

import UIKit

class DownloadView: UIView {
  var imageView: UIImageView = {
    let image = UIImage(systemName: "square.and.arrow.down")!
    image.withRenderingMode(.alwaysTemplate)
    
    let view = UIImageView(image: image)
    view.tintColor = .lightGray
    view.contentMode = .scaleAspectFit
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
      centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
      centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 30)
    ])
  }
}
