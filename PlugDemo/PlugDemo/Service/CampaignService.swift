//
//  CampaignService.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import Foundation

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
