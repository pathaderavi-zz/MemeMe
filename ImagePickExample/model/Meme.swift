//
//  Meme.swift
//  ImagePickExample
//
//  Created by Ravikiran Pathade on 1/23/18.
//  Copyright © 2018 Ravikiran Pathade. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
