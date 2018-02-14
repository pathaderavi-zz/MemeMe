//
//  CollectionViewControllerMeme.swift
//  ImagePickExample
//
//  Created by Ravikiran Pathade on 2/13/18.
//  Copyright © 2018 Ravikiran Pathade. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewControllerMeme: UICollectionViewController {
    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
    override func viewDidLoad() {
            self.collectionView?.register(MemeCellCollection.self, forCellWithReuseIdentifier: "MemeCell")
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCellCollection
       
        let memeImages = self.memes[indexPath.row]
        let imageview:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageview.contentMode = UIViewContentMode.scaleAspectFit
        let image = memeImages.memedImage
        imageview.image = image
        cell.contentView.addSubview(imageview)
        
        return cell
}
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetail = self.storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailController
        memeDetail.memes = memes[indexPath.row]
        self.navigationController?.pushViewController(memeDetail, animated: true)
        
    }
}
