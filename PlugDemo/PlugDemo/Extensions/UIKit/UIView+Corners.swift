//
//  UIView+Corners.swift
//  PlugDemo
//
//  Created by projas on 9/1/20.
//

import UIKit

extension UIView {
  func roundCorners(to value: CGFloat) {
    self.layer.cornerRadius = value
    self.clipsToBounds = true
  }
  
  func border(width: CGFloat, color: UIColor) {
    self.layer.borderWidth = width
    self.layer.borderColor = color.cgColor
  }
}
