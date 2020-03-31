//
//  MovieListViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 7/23/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private struct keys {
        static let popular = "popular"
        static let topRated = "top_rated"
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        fetchMovies(endpoint: keys.popular)
        let nib = UINib.init(nibName: Constants.cellIdentifiers.movieCell, bundle: nil)
        self.tblMovies.register(nib, forCellReuseIdentifier: Constants.cellIdentifiers.movieCell)
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                fetchMovies(endpoint: keys.popular)
            case 1:
                fetchMovies(endpoint: keys.topRated)
            default:
                break
        }
    }
    
    var movies = [Movie]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! != "" {
            segmentedControl.alpha = 0.5
            segmentedControl.isUserInteractionEnabled = false
            let completion = { (fetchedMovies: [Movie]) in
                SVProgressHUD.dismiss()
                if fetchedMovies.count > 0 {
                    self.movies = fetchedMovies
                    self.tblMovies.reloadData()
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    self.tblMovies.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                }
            }
            MovieManager.searchMovie(query: searchBar.text!, completion: completion)
        } else {
            segmentedControl.alpha = 1
            segmentedControl.isUserInteractionEnabled = true
            switch segmentedControl.selectedSegmentIndex {
                case 0:
                    fetchMovies(endpoint: keys.popular)
                case 1:
                    fetchMovies(endpoint: keys.topRated)
                default:
                    break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.movieCell, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.cellSetup(movie: movie, useCharacter: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.segues.showMovieDetail, sender: self)
    }
    
    private func fetchMovies(endpoint: String) {
        let completion = { (fetchedMovies: [Movie]) in
            SVProgressHUD.dismiss()
            self.movies = fetchedMovies
            self.tblMovies.reloadData()
            let indexPath = NSIndexPath(row: 0, section: 0)
            self.tblMovies.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
        }
        
        SVProgressHUD.show()
        
        MovieManager.fetchMovies(endpoint: endpoint, completion: completion)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segues.showMovieDetail {
            if let indexPath = tblMovies.indexPathForSelectedRow {
                let controller = segue.destination as! MovieViewController
                controller.movie = movies[indexPath.row]
            }
        }
    }

}
