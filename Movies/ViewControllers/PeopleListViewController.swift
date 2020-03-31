//
//  PeopleListViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/1/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class PeopleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tblPeople: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchPeople()
        let nib = UINib.init(nibName: Constants.cellIdentifiers.personCell, bundle: nil)
        self.tblPeople.register(nib, forCellReuseIdentifier: Constants.cellIdentifiers.personCell)
        self.tblPeople.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.segues.showPersonDetails, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.personCell, for: indexPath) as! PersonCell
        
        let person = people[indexPath.row]
        cell.cellSetup(person: person)
        
        return cell
    }
    
    private func fetchPeople() {
        let completion = { (fetchedPeople: [Person]) in
            SVProgressHUD.dismiss()
            self.people = fetchedPeople
            self.tblPeople.reloadData()
        }
        
        SVProgressHUD.show()
        
        PeopleManager.fetchPeople(completion: completion)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! != "" {
            let completion = { (fetchedPeople: [Person]) in
                SVProgressHUD.dismiss()
                if fetchedPeople.count > 0 {
                    self.people = fetchedPeople
                    self.tblPeople.reloadData()
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    self.tblPeople.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                }
            }
            PeopleManager.searchPerson(query: searchBar.text!, completion: completion)
        } else {
            fetchPeople()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segues.showPersonDetails {
            if let indexPath = tblPeople.indexPathForSelectedRow {
                let controller = segue.destination as! PersonViewController
                controller.person = people[indexPath.row]
            }
        }
    }

}
