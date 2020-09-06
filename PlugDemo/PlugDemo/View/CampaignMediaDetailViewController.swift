//
//  CampaignMediaDetailViewController.swift
//  PlugDemo
//
//  Created by projas on 9/3/20.
//

import UIKit
import AVFoundation
import AVKit

class CampaignMediaDetailViewController: UIViewController {
  var media: Media!
  
  var mediaImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .large)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.color = .white
    return view
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
    view.backgroundColor = .black
    configureMediaImageView()
    configureActivityIndicator()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    playVideo()
  }
  
  func playVideo() {
    
    guard let url = URL(string: media.downloadUrl) else {
      return
    }
    
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      
      let videoData = try? Data(contentsOf: url)
      var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      documentsPath.append("/filename.MOV")
      let destinationPath = documentsPath.joined()
      
      FileManager.default.createFile(atPath: destinationPath, contents: videoData, attributes: nil)
      
      let fileUrl = URL(fileURLWithPath: destinationPath)
      
      DispatchQueue.main.async {
        let player = AVPlayer(url: fileUrl)
        let controller = AVPlayerViewController()
        controller.player = player

        self.view.addSubview(controller.view)
        self.addChild(controller)
        
        self.activityIndicator.stopAnimating()
        player.play()
      }
    }
  }
  
  func configureMediaImageView() {
    view.addSubview(mediaImageView)
    
    CampaignService.shared.downloadImage(from: media.coverPhotoUrl) { [weak self] image in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        self.mediaImageView.image = image
      }
    }
    
    NSLayoutConstraint.activate([
      view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: mediaImageView.topAnchor),
      view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mediaImageView.bottomAnchor),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mediaImageView.trailingAnchor),
      view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: mediaImageView.leadingAnchor)
    ])
  }
  
  func configureActivityIndicator() {
    view.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      view.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor),
      view.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
      
      activityIndicator.heightAnchor.constraint(equalToConstant: 200),
      activityIndicator.widthAnchor.constraint(equalToConstant: 200)
    ])
    
    activityIndicator.startAnimating()
  }
}
