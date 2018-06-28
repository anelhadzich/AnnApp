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
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=3d4d979cdacbd1d26140caec278b07c3&language=en-US&page=1"
    let urlTVShows = "https://api.themoviedb.org/3/tv/top_rated?api_key=3d4d979cdacbd1d26140caec278b07c3&language=en-US&page=1"
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

  //  var moviesDataModel = MoviesDataModel()
    
    var movieDictionaryArray:[[String:AnyObject]] = []
    var TVShowsDictionaryArray: [[String:AnyObject]] = []
    
    var passedTitle: [String:AnyObject]?
    var passedOverview: [String:AnyObject]?
    
    let baseURL = "http://image.tmdb.org/t/p/w500/"

    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

        getMovieData(url: url)
        getTVShowsData(url: urlTVShows)
        
        var baseURL = "http://image.tmdb.org/t/p/w500/"
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Get top rated movies
    func getMovieData(url: String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let movieJSON : JSON = JSON(response.result.value!)
                
                if let temp = movieJSON["results"].arrayObject {
                    self.movieDictionaryArray = temp as! [[String:AnyObject]]
                    self.tableView.reloadData()
                }
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    //MARK: Get top rated tv shows
    func getTVShowsData(url: String){
        
        Alamofire.request(urlTVShows, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let TVShowsJSON : JSON = JSON(response.result.value!)
                
                if let tempTVShows = TVShowsJSON["results"].arrayObject {
                    self.TVShowsDictionaryArray = tempTVShows as! [[String:AnyObject]]
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (TVShowsDictionaryArray.count) - 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.accessoryType = .disclosureIndicator
       
        if let moviePicture = movieDictionaryArray[indexPath.row]["poster_path"] as? String {
                   
            let fullPath = baseURL + moviePicture
            let resource = ImageResource(downloadURL: URL(string: fullPath)!, cacheKey: fullPath)
 
        if segmentedControl.selectedSegmentIndex == 0 {
        cell.titleLabel.text = movieDictionaryArray[indexPath.row]["title"] as? String
        cell.descriptionLabel.text = movieDictionaryArray[indexPath.row]["overview"] as? String
        cell.numberLabel.text = " \(indexPath.row + 1)"
            
           cell.moviePic.kf.setImage(with: resource)
            return cell
            }

            
            if let TVShowPicture = TVShowsDictionaryArray[indexPath.row]["poster_path"] as? String {
            
                let fullPathTVShows = baseURL + TVShowPicture
                let resource = ImageResource(downloadURL: URL(string: fullPathTVShows)!, cacheKey: fullPathTVShows)
                
            cell.titleLabel.text = TVShowsDictionaryArray[indexPath.row]["original_name"] as? String
            cell.descriptionLabel.text = TVShowsDictionaryArray[indexPath.row]["overview"] as? String
            cell.numberLabel.text = " \(indexPath.row + 1)"
                
                cell.moviePic.kf.setImage(with: resource)
                return cell
        }
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if segmentedControl.selectedSegmentIndex == 0 {
            passedTitle = movieDictionaryArray[indexPath.row]
            passedOverview = movieDictionaryArray[indexPath.row]
        } else {
            passedTitle = TVShowsDictionaryArray[indexPath.row]
            passedOverview = TVShowsDictionaryArray[indexPath.row]
        }
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        print(segmentedControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            _ = segue.destination as! DetailViewController

            let viewController = segue.destination as! DetailViewController
            viewController.passedValue = passedTitle

        }
    }
    
    
}


