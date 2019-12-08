//
//  DetailedCell.swift
//  MemeMe
//
//  Created by Aly Essam on 7/9/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit

class DetailedCell: UIViewController {

    // MARK: Properties
    
    var detailed: Meme!
    @IBOutlet weak var detailedMemedImage: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        detailedMemedImage.image = detailed.memedImage
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         self.tabBarController?.tabBar.isHidden = false
    }
}
