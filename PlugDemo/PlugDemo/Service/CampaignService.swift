//
//  CampaignService.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class CampaignService: CampaignOperation {
  let session = URLSession.shared
  
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
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    
    let task = session.dataTask(with: url) { (data, response, error) in
      
      guard
        error == nil,
        let data = data,
        let image = UIImage(data: data)
      else {
        completion(nil)
        return
      }
      
      completion(image)
    }
    
    task.resume()
  }
}
