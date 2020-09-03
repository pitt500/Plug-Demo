//
//  CampaignCell.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class CampaignCell: UICollectionViewCell {
  private var vStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 4
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private var hStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.backgroundColor = .white
    stack.border(width: 1, color: UIColor.lightGray.withAlphaComponent(0.6))
    stack.roundCorners(to: 6)
    return stack
  }()
  
  var mediaView: MediaView = {
    let view = MediaView()
    view.backgroundColor = .black
    view.translatesAutoresizingMaskIntoConstraints = false
    view.border(width: 1, color: UIColor.lightGray.withAlphaComponent(0.6))
    view.roundCorners(to: 6)
    return view
  }()
  
  var videoView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.layer.opacity = 0.9//0.3
    
    return view
  }()
  
  var trackingLinkView: TrackingLinkView {
    let view = TrackingLinkView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.border(width: 0.5, color: UIColor.lightGray.withAlphaComponent(0.6))
    return view
  }
  
  var downloadView: DownloadView {
    let view = DownloadView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.border(width: 0.5, color: UIColor.lightGray.withAlphaComponent(0.6))
    return view
  }
  
  weak var delegate: CampaignInteraction?
  var media: Media!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with media: Media, delegate: CampaignInteraction?) {
    self.delegate = delegate
    self.media = media
    
    self.mediaView.playerButton.addTarget(self, action: #selector(CampaignCell.buttonTapped), for: .touchUpInside)
    
    CampaignService.shared.downloadImage(from: media.coverPhotoUrl) { [weak self] image in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.mediaView.imageView.image = image
        
        if media.mediaType == .video {
          self.mediaView.imageView.layer.opacity = 0.7
          self.mediaView.playerImageView.isHidden = false
        } else {
          self.mediaView.imageView.layer.opacity = 1.0
          self.mediaView.playerImageView.isHidden = true
        }
      }
    }
  }
  
  @objc func buttonTapped() {
    delegate?.didTapMedia(media)
  }
  
}

extension CampaignCell {
  func setConstraints() {
    addSubview(vStackView)
    vStackView.addArrangedSubview(mediaView)
    vStackView.addArrangedSubview(hStackView)
    hStackView.addArrangedSubview(trackingLinkView)
    hStackView.addArrangedSubview(downloadView)

    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: vStackView.topAnchor),
      bottomAnchor.constraint(equalTo: vStackView.bottomAnchor),
      leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
      trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),
      
      vStackView.bottomAnchor.constraint(equalTo: hStackView.bottomAnchor),
      hStackView.heightAnchor.constraint(equalToConstant: 50),
      
      vStackView.topAnchor.constraint(equalTo: mediaView.topAnchor),
      vStackView.leadingAnchor.constraint(equalTo: mediaView.leadingAnchor),
      vStackView.trailingAnchor.constraint(equalTo: mediaView.trailingAnchor),
    ])
  }
}

protocol CampaignInteraction: AnyObject {
  func didTapMedia(_ media: Media)
}
