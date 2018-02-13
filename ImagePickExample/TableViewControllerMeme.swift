//
//  TableViewControllerMeme.swift
//  ImagePickExample
//
//  Created by Ravikiran Pathade on 2/12/18.
//  Copyright © 2018 Ravikiran Pathade. All rights reserved.
//

import Foundation
import UIKit

class TableViewControllerMeme: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var memes = [Meme]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
}
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! UITableViewCell
        cell.textLabel!.text = memes[indexPath.row].topText
        cell.detailTextLabel!.text = memes[indexPath.row].bottomText
        cell.imageView?.image = memes[indexPath.row].memedImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    
}


