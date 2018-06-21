//
//  ViewController.swift
//  AnnApp
//
//  Created by Anel Hadzic on 19/06/2018.
//  Copyright © 2018 Anel Hadzic. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=3d4d979cdacbd1d26140caec278b07c3&language=en-US&page=1"
    var moviesDataModel = MoviesDataModel()
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     getWeatherData(url: url)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData(url: String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let movieJSON : JSON = JSON(response.result.value!)
                
                let tempResult = movieJSON["results"][2]["title"]
                self.movieNameLabel.text = movieJSON["results"][2]["title"].stringValue
                
                print(tempResult)
                
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                
            }
        }
        
    }
    
    func updateMovieData(json: JSON) {
        
        let tempResult = json["results"]["0"].doubleValue
        
        print(tempResult)
    }
    
    func updateUI(){
        
    }

}


