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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var moviesDataModel = MoviesDataModel()
    
    var movieDictionaryArray:[[String:AnyObject]] = []
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
        
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print (movieDictionaryArray.count)
        return (movieDictionaryArray.count) - 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        
        cell.titleLabel.text = movieDictionaryArray[indexPath.row]["title"] as? String
        cell.descriptionLabel.text = movieDictionaryArray[indexPath.row]["overview"] as? String
        cell.numberLabel.text = " \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "detail" {
                let detailViewController = segue.destination as! DetailViewController
                
                if let selectedMovieCell = sender as? CustomTableViewCell {
                    let indexPath = tableView.indexPath(for: selectedMovieCell)!
                    let selectedMovie = movieDictionaryArray[indexPath.row]
                
                    tableView.reloadData()
                    print(selectedMovieCell)
                }
            }
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
}


