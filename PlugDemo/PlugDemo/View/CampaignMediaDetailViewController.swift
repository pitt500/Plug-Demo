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
  
  var playPauseView: PlayPauseView = {
    let view = PlayPauseView()
    view.alpha = 0.0
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  var activityIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .large)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.color = .white
    return view
  }()
  
  var isShowingControls = false {
    didSet {
      animateControlsWithTimer()
    }
  }
  
  var timer: Timer?
  
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
    configureGestures()
    configureObservers()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
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
  
  @objc func handleControls(sender: UITapGestureRecognizer) {
    isShowingControls.toggle()
  }
  
  func animateControlsWithTimer() {
    animatePlayPause()
    
    if isShowingControls {
      if playPauseView.isShowingPause {
        NotificationCenter.default.post(name: PlayerNotification.dismissAfterTime, object: nil)
      } else {
        removeTimer()
      }
    } else {
      removeTimer()
    }
  }
  
  @objc func dismissPlayer(notification: Notification) {
    timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
      self.isShowingControls = false
    }
  }
  
  @objc func removeTimer() {
    timer?.invalidate()
  }
  
  func animatePlayPause() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.playPauseView.alpha = self.isShowingControls ? 1.0 : 0.0
    }
  }
  
  func downloadVideo() {
    var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    documentsPath.append("/\(self.media.id).MOV")
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
      player.actionAtItemEnd = .none
      
      NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.playerDidReachEnd(notification:)),
        name: .AVPlayerItemDidPlayToEndTime,
        object: player.currentItem
      )
      
      let controller = AVPlayerViewController()
      controller.showsPlaybackControls = false
      controller.player = player

      self.view.addSubview(controller.view)
      self.addChild(controller)
      self.view.bringSubviewToFront(self.playPauseView)
      self.playPauseView.avPlayer = player
      
      self.activityIndicator.stopAnimating()
      player.play()
    }
  }
  
  func configureMediaImageView() {
    view.addSubview(mediaImageView)
    view.addSubview(playPauseView)
    
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
      view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: mediaImageView.leadingAnchor),
      
      view.topAnchor.constraint(equalTo: playPauseView.topAnchor),
      view.bottomAnchor.constraint(equalTo: playPauseView.bottomAnchor),
      view.trailingAnchor.constraint(equalTo: playPauseView.trailingAnchor),
      view.leadingAnchor.constraint(equalTo: playPauseView.leadingAnchor)
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
  
  func configureGestures() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
    view.addGestureRecognizer(panGesture)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleControls))
    view.addGestureRecognizer(tapGesture)
  }
  
  func configureObservers() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(dismissPlayer(notification:)),
      name: PlayerNotification.dismissAfterTime,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(removeTimer),
      name: PlayerNotification.invalidateTimer,
      object: nil
    )
  }
  
  @objc func playerDidReachEnd(notification: Notification) {
    guard let playerItem = notification.object as? AVPlayerItem else {
      return
    }
    
    restartVideo(playerItem)
  }
  
  func restartVideo(_ playerItem: AVPlayerItem) {
    playerItem.seek(to: .zero, completionHandler: nil)
  }
}
