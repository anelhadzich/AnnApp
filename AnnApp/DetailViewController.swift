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
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let url = URL(string: "https://9to5mac.files.wordpress.com/2018/06/ios-12-beta-2-changes-features-9to5mac.jpg?quality=82&w=2000#038;strip=all&w=1600")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImage.kf.setImage(with: url)

        if let data = passedValue!["original_name"] {
            titleLabel.text = (passedValue?["original_name"] as! String)
        } else {
            titleLabel.text = (passedValue!["title"] as! String)
        }
        	
        
        textView.text = passedValue!["overview"] as? String

        }
        
        // Do any additional setup after loading the view.
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
