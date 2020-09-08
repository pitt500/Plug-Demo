//
//  PlayPauseButton.swift
//  PlugDemo
//
//  Created by projas on 9/6/20.
//

import UIKit
import AVFoundation

class PlayPauseView: UIView {
  weak var avPlayer: AVPlayer?
  
  lazy var playImage = UIImage(systemName: "play.fill")
  lazy var pauseImage = UIImage(systemName: "pause.fill")
  
  lazy var playImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "play.fill")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isHidden = true
    imageView.tintColor = .white
    
    return imageView
  }()
  
  var pauseImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "pause.fill")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.tintColor = .white
    
    return imageView
  }()
  
  var pauseBackground: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  var playButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    button.imageView?.contentMode  = .scaleAspectFit
    button.imageView?.tintColor  = .white
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  var isShowingPause = true {
    didSet {
      didPressPlayButton()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureView()
    configureButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView() {
    addSubview(pauseBackground)
    addSubview(playButton)
    
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: pauseBackground.topAnchor),
      bottomAnchor.constraint(equalTo: pauseBackground.bottomAnchor),
      trailingAnchor.constraint(equalTo: pauseBackground.trailingAnchor),
      leadingAnchor.constraint(equalTo: pauseBackground.leadingAnchor),
      
      centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
      centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
      playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
      playButton.widthAnchor.constraint(equalToConstant: 70),
    ])
  }
  
  func configureButton() {
    playButton.addTarget(self, action: #selector(didPressButton(_:)), for: .touchUpInside)
  }
  
  @objc func didPressButton(_ sender: UIButton) {
    isShowingPause.toggle()
  }
  
  func didPressPlayButton() {
    if isShowingPause {
      NotificationCenter.default.post(name: PlayerNotification.dismissAfterTime, object: nil)
      avPlayer?.play()
      playButton.setImage(pauseImage, for: .normal)
    } else {
      NotificationCenter.default.post(name: PlayerNotification.invalidateTimer, object: nil)
      avPlayer?.pause()
      playButton.setImage(playImage, for: .normal)
    }
  }
}
