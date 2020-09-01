//
//  Campaign.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import Foundation

struct Campaign: Codable {
  let id: String
  let campaignName: String
  let campaignIconUrl: String
  let payPerInstall: String
  let medias: [Media]
}
