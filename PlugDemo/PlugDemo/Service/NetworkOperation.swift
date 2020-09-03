//
//  NetworkOperation.swift
//  PlugDemo
//
//  Created by projas on 9/2/20.
//

import UIKit

protocol NetworkOperation {
  func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}
