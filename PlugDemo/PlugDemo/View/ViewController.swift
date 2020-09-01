//
//  ViewController.swift
//  PlugDemo
//
//  Created by projas on 8/31/20.
//

import UIKit

class CampaignViewController: UIViewController {
  
  let service: CampaignOperation = CampaignService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
    
    service.getFeed { result in
      switch result {
      case .success(let campaigns):
        print(campaigns)
      case .failure(let error):
        print(error)
      }
    }
  }


}

