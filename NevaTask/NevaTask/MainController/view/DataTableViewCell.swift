//
//  DataTableViewCell.swift
//  NevaTask
//
//  Created by Vengababu Maparthi on 13/02/19.
//  Copyright © 2019 Vengababu Maparthi. All rights reserved.
//

import UIKit
import Kingfisher

class DataTableViewCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:Data! {
        didSet {
            self.designation.text = data.skill
            self.name.text = data.name
            self.activityIndicator.startAnimating()
            
            self.profileImg.kf.setImage(with: URL(string: data.image!),
                                         placeholder:UIImage.init(named: "DefaultImg"),
                                         options: [.transition(ImageTransition.fade(1))],
                                         progressBlock: { receivedSize, totalSize in
            },
                                         completionHandler: { image, error, cacheType, imageURL in
                                                self.activityIndicator.stopAnimating()
            })
        }
    }
    
    
    static var identifer:String{
        return String(describing: self)
    }

}
