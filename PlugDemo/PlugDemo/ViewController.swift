//
//  ViewController.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class ViewController: UIViewController {
  
  let service: CampaignOperation = CampaignService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
    
    service.getFeed { campaign in
      print(campaign)
    } failure: { error in
      print(error)
    }

  }


}

