//
//  CastAndCrewViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/8/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class CastAndCrewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var castAndCrewTbl: UITableView!
    var people = [CastAndCrew]()
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: Constants.cellIdentifiers.castAndCrewCell, bundle: nil)
        self.castAndCrewTbl.register(nib, forCellReuseIdentifier: Constants.cellIdentifiers.castAndCrewCell)
        self.title = movie?.title ?? ""
        fetchCastAndCrew(isCast: true, movieId: movie!.movieId)
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                fetchCastAndCrew(isCast: true, movieId: movie!.movieId)
            case 1:
                fetchCastAndCrew(isCast: false, movieId: movie!.movieId)
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.castAndCrewCell, for: indexPath) as! CastAndCrewCell
        
        let person = people[indexPath.row]
        cell.cellSetup(person: person)
        
        return cell
    }

    private func fetchCastAndCrew(isCast: Bool, movieId: Int) {
        let completion = { (fetchedPeople: [CastAndCrew]) in
            SVProgressHUD.dismiss()
            self.people = fetchedPeople
            self.castAndCrewTbl.reloadData()
            let indexPath = NSIndexPath(row: 0, section: 0)
            self.castAndCrewTbl.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
        }
        
        SVProgressHUD.show()
        MovieManager.fetchCastAndCrew(isCast: isCast, movieId: movieId, completion: completion)
    }

}
