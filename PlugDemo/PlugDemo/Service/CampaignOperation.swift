//
//  CampaignOperation.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import Foundation

protocol CampaignOperation {
  func getFeed(result: @escaping (Result<[Campaign], Error>) -> Void)
}
