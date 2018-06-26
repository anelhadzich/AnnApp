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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=3d4d979cdacbd1d26140caec278b07c3&language=en-US&page=1"
    let urlTVShows = "https://api.themoviedb.org/3/tv/top_rated?api_key=3d4d979cdacbd1d26140caec278b07c3&language=en-US&page=1"
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

  //  var moviesDataModel = MoviesDataModel()
    
    var movieDictionaryArray:[[String:AnyObject]] = []
    var TVShowsDictionaryArray: [[String:AnyObject]] = []
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        getMovieData(url: url)
        getTVShowsData(url: urlTVShows)
        
        print(segmentedControl.selectedSegmentIndex)
        
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
                  //  print(self.movieDictionaryArray)
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
                    
                   // print(self.TVShowsDictionaryArray)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print (movieDictionaryArray.count)
        
        return (TVShowsDictionaryArray.count) - 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.accessoryType = .disclosureIndicator

        if segmentedControl.selectedSegmentIndex == 0 {
        cell.titleLabel.text = movieDictionaryArray[indexPath.row]["title"] as? String
        cell.descriptionLabel.text = movieDictionaryArray[indexPath.row]["overview"] as? String
        cell.numberLabel.text = " \(indexPath.row + 1)"
        } else {


            cell.titleLabel.text = TVShowsDictionaryArray[indexPath.row]["original_name"] as? String
            cell.descriptionLabel.text = TVShowsDictionaryArray[indexPath.row]["overview"] as? String
            cell.numberLabel.text = " \(indexPath.row + 1)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        performSegue(withIdentifier: "detail", sender: UITableViewCell.self)
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        print(segmentedControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detail" {
//            let detailViewController = segue.destination as! DetailViewController
//
//            if let selectedMovieCell = sender as? CustomTableViewCell {
//                let indexPath = tableView.indexPath(for: selectedMovieCell)!
//                let selectedMovie = movieDictionaryArray[indexPath.row]
//            }
//
//        }
    }



