//
//  GVanillaTableViewCell.swift
//  GVanillaTableView
//
//  Created by Glenn Posadas on 3/28/17.
//  Copyright © 2017 Citus Labs. All rights reserved.
//

import Kingfisher
import UIKit

class GVanillaTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var shutterStock_ImageView: UIImageView!
    
    public var data: Data! {
        didSet {
            
            if let url = URL(string: self.data.assets!.preview!.url!) {
                self.shutterStock_ImageView.kf.indicatorType = .activity
                self.shutterStock_ImageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [.transition(.fade(1))],
                    progressBlock: { (receivedSize, totalSize) in },
                    completionHandler: { (image, error, cacheType, imageURL) in
                        
                })
            }
        }
    }
}
