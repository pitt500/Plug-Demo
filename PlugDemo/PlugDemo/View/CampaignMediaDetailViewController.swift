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
  var viewTranslation = CGPoint(x: 0, y: 0)
  
  var mediaImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0.7
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
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    downloadVideo()
  }
  
  @objc func handleDismiss(sender: UIPanGestureRecognizer) {
    switch sender.state {
    case .changed:
      viewTranslation = sender.translation(in: view)
      UIView.animate(
        withDuration: 0.5,
        delay: 0,
        usingSpringWithDamping: 0.7,
        initialSpringVelocity: 1,
        options: .curveEaseOut,
        animations: {
          self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
        },
        completion: nil
      )
    case .ended:
      if viewTranslation.y < 200 {
        UIView.animate(
          withDuration: 0.5,
          delay: 0,
          usingSpringWithDamping: 0.7,
          initialSpringVelocity: 1,
          options: .curveEaseOut,
          animations: {
            self.view.transform = .identity
          },
          completion: nil
        )
      } else {
        dismiss(animated: true, completion: nil)
      }
    default:
      break
    }
  }
  
  func downloadVideo() {
    var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    documentsPath.append("\(self.media.id).MOV")
    let destinationPath = documentsPath.joined()
    
    if FileManager.default.fileExists(atPath: destinationPath) {
      let fileUrl = URL(fileURLWithPath: destinationPath)
      playVideo(withFileUrl: fileUrl)
      return
    }
    
    guard let url = URL(string: media.downloadUrl) else {
      return
    }
    
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      
      let videoData = try? Data(contentsOf: url)
      FileManager.default.createFile(atPath: destinationPath, contents: videoData, attributes: nil)
      
      let fileUrl = URL(fileURLWithPath: destinationPath)
      self.playVideo(withFileUrl: fileUrl)
    }
  }
  
  func playVideo(withFileUrl fileUrl: URL) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      let player = AVPlayer(url: fileUrl)
      let controller = AVPlayerViewController()
      controller.showsPlaybackControls = false
      controller.player = player

      self.view.addSubview(controller.view)
      self.addChild(controller)
      
      self.activityIndicator.stopAnimating()
      player.play()
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
