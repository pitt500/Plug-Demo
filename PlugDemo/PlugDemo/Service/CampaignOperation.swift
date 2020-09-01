//
//  CampaignOperation.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import Foundation

protocol CampaignOperation {
  func getFeed(completion: @escaping ([Campaign]) -> Void, failure: @escaping (Error) -> Void) 
}
