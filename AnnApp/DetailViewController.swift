//
//  DetailViewController.swift
//  AnnApp
//
//  Created by Anel Hadzic on 25/06/2018.
//  Copyright © 2018 Anel Hadzic. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
   
    var passedValue: [String:AnyObject]?
    
    let baseURL = "http://image.tmdb.org/t/p/w500/"
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pictureURL = passedValue!["backdrop_path"] as? String {
            print(pictureURL)
           
            var fullPath = baseURL + pictureURL
            let resource = ImageResource(downloadURL: URL(string: fullPath)!, cacheKey: fullPath)
            
            detailImage.kf.setImage(with: resource)
        
      if let data = passedValue!["original_name"] {
            titleLabel.text = (passedValue?["original_name"] as! String)
        } else {
            titleLabel.text = (passedValue!["title"] as! String)
        }
        	
        
        textView.text = passedValue!["overview"] as? String

        }
    }
        
        // Do any additional setup after loading the view.
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
