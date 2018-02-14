//
//  MemeDetailController.swift
//  ImagePickExample
//
//  Created by Ravikiran Pathade on 2/14/18.
//  Copyright © 2018 Ravikiran Pathade. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailController:UIViewController{
    @IBOutlet weak var detailImage: UIImageView!
    var indexPath: IndexPath!
    var memes: Meme!

    override func viewDidLoad() {
       self.detailImage.image = memes.memedImage
    }
}
