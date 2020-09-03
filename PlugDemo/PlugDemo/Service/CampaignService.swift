//
//  CampaignService.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class CampaignService: CampaignOperation {
  static let shared = CampaignService()
  let session = URLSession.shared
  let cache = NSCache<NSString, UIImage>()
  
  func getFeed(result: @escaping (Result<[Campaign], Error>) -> Void) {
    let url = URL(string: "https://www.plugco.in/public/take_home_sample_feed")
    let request = URLRequest(url: url!)
    session.dataTask(with: request) { (data, response, error) in
      
      if let error = error {
        result(.failure(error))
        return
      }
      
      guard let data = data else {
        result(.failure(NetworkError.noData))
        return
      }
      
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      guard let decoded = try? decoder.decode(CampaignResponse.self, from: data) else {
        result(.failure(NetworkError.invalidFormat))
        return
      }
      
      result(.success(decoded.campaigns))
      
    }.resume()
  }
}

extension CampaignService: NetworkOperation {
  func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
    let key = NSString(string: urlString)
    if let image = cache.object(forKey: key) {
      completion(image)
      return
    }
    
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    
    let task = session.dataTask(with: url) { [weak self] (data, response, error) in
      
      guard
        let self = self,
        error == nil,
        let data = data,
        let image = UIImage(data: data)
      else {
        completion(nil)
        return
      }
      print("loading image...")
      self.cache.setObject(image, forKey: key)
      completion(image)
    }
    
    task.resume()
  }
}
