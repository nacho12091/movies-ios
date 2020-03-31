//
//  PersonViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/6/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class PersonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private struct keys {
        static let biography = "biography"
        static let knownForDepartment = "known_for_department"
        static let gender = "gender"
        static let popularity = "popularity"
        static let birthday = "birthday"
        static let placeOfBirth = "place_of_birth"
        static let noBiography = "There is not a biography for this person"
    }

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personBiography: UITextView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var knownForCollection: UICollectionView!
   
    var person: Person? = nil
    var knForMovies = [Movie]()
    var biographyTextStatus = false
    
    let reuseIdentifier = "knForCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPersonDetails(id: person!.personId)
        personBiography.textContainerInset = UIEdgeInsets.zero
        personBiography.textContainer.lineFragmentPadding = 0
        personBiography.textContainer.maximumNumberOfLines = 3
        personBiography.textContainer.lineBreakMode = .byTruncatingTail
        personBiography.textContainer.heightTracksTextView = true
        personName.text = person!.personName
        personImage.sd_setImage(with: URL(string: person?.personPhoto ?? ""))

        fetchKnownForMovies(userId: person!.personId)
    }
    
    private func fetchPersonDetails(id: Int) {
        let completion = { (fetchedInfo: [String: Any]) in
            SVProgressHUD.dismiss()
            let pBiography = fetchedInfo[keys.biography] as? String
            let knForDep = fetchedInfo[keys.knownForDepartment] as? String
            let gender = fetchedInfo[keys.gender] as? Int
            let popularity = fetchedInfo[keys.popularity] as? Double
            let birthday = fetchedInfo[keys.birthday] as? String ?? ""
            let placeOfBirth = fetchedInfo[keys.placeOfBirth] as? String
            if (pBiography != "") {
                self.personBiography.text = pBiography
                self.person?.personDescription = pBiography!
            } else {
                self.personBiography.text = keys.noBiography
            }
            self.person?.knownForDepartment = knForDep!
            self.person?.gender = gender!
            self.person?.popularity = Int(popularity ?? 0)
            self.person?.birthday = birthday
            self.person?.placeOfBirth = placeOfBirth ?? ""
        }
        
        SVProgressHUD.show()
        
        PeopleManager.getPersonDetails(id: id, completion: completion)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case Constants.segues.showPersonFacts:
                let controller = segue.destination as? UINavigationController
                let tbController = controller?.viewControllers.first as? PersonInfoViewController
                tbController?.person = person
            case Constants.segues.showKnownForInfo:
                let controller = segue.destination as? PersonKnownForListViewController
                controller?.personId = person?.personId ?? 0
            case Constants.segues.showRateImageScreen:
                let controller = segue.destination as? RateImageViewController
                controller?.image = person?.personPhoto ?? ""
                controller?.screenTitle = person?.personName ?? ""
            case Constants.segues.showReadMorePerson:
                let controller = segue.destination as? UINavigationController
                let tbController = controller?.viewControllers.first as? ReadMoreViewController
                tbController?.person = person
                tbController?.descriptionTitle = keys.biography
            default:
                print("No segue")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.knForMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! KnownForCollectionViewCell
        
        cell.cellSetup(movie: self.knForMovies[indexPath.item])
        return cell
    }

    private func fetchKnownForMovies(userId: Int) {
        let completion = { (fetchedMovies: [Movie]) in
            SVProgressHUD.dismiss()
            self.knForMovies = fetchedMovies
            self.knownForCollection.reloadData()
        }
        
        SVProgressHUD.show()
        
        PeopleManager.fetchKnownForMovies(userId: userId, completion: completion)
    }
    
}
