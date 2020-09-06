//
//  Media.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import Foundation

struct Media: Codable {

  enum Format: String, Codable {
    case video
    case photo
  }
  
  var id = UUID().uuidString
  let coverPhotoUrl: String
  let downloadUrl: String
  let trackingLink: String
  let mediaType: Format
  
  private enum CodingKeys: String, CodingKey {
    case coverPhotoUrl
    case downloadUrl
    case trackingLink
    case mediaType
  }
}
