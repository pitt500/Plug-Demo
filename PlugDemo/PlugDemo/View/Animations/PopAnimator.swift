//
//  PopAnimator.swift
//  PlugDemo
//
//  Created by projas on 9/6/20.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let duration = 0.3
  var presenting = true
  var originFrame = CGRect.zero
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!
    let videoView = presenting ? toView : transitionContext.view(forKey: .from)!
    
    let initialFrame = presenting ? originFrame : videoView.frame
    let finalFrame = presenting ? videoView.frame : originFrame
    
    let xScaleFactor = presenting ?
      initialFrame.width / finalFrame.width :
      finalFrame.width / initialFrame.width
    
    let yScaleFactor = presenting ?
      initialFrame.height / finalFrame.height :
      finalFrame.height / initialFrame.height
    
    let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
    
    if presenting {
      videoView.transform = scaleTransform
      videoView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
      videoView.clipsToBounds = true
    }
    
    videoView.layer.cornerRadius = presenting ? 20.0 : 0.0
    videoView.layer.masksToBounds = true
    
    containerView.addSubview(toView)
    containerView.bringSubviewToFront(videoView)
    
    UIView.animate(
      withDuration: duration,
//      delay: 0.0,
//      usingSpringWithDamping: 0.5,
//      initialSpringVelocity: 0.5,
      animations: {
        videoView.transform = self.presenting ? .identity : scaleTransform
        videoView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        videoView.layer.cornerRadius = self.presenting ? 0.0 : 20.0
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      }
    )
  }
}
