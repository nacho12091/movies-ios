//
//  PersonKnownForListViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/13/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD

class PersonKnownForListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblKnFor: UITableView!
    
    var personId: Int = 0
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: Constants.cellIdentifiers.movieCell, bundle: nil)
        self.tblKnFor.register(nib, forCellReuseIdentifier: Constants.cellIdentifiers.movieCell)
        self.tblKnFor.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        fetchKnownForMovies(userId: personId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.movieCell, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.cellSetup(movie: movie, useCharacter: true)
        
        return cell
    }
    
    private func fetchKnownForMovies(userId: Int) {
        let completion = { (fetchedMovies: [Movie]) in
            SVProgressHUD.dismiss()
            self.movies = fetchedMovies
            self.tblKnFor.reloadData()
        }

        SVProgressHUD.show()

        PeopleManager.fetchKnownForMovies(userId: userId, completion: completion)
    }

}
