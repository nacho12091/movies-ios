//
//  MovieViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 7/23/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var castCollectionview: UICollectionView!

    var movie: Movie? = nil
    var cast = [CastAndCrew]()
    
    private struct keys {
        static let reuseIdentifier = "cell"
        static let descriptionTitle = "Overview"
        static let rate = "rate"
        static let login = "login"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCastAndCrew(isCast: true, movieId: movie!.movieId)
        movieDescription.textContainerInset = UIEdgeInsets.zero
        movieDescription.textContainer.lineFragmentPadding = 0
        movieDescription.textContainer.maximumNumberOfLines = 3
        movieDescription.textContainer.lineBreakMode = .byTruncatingTail
        movieDescription.textContainer.heightTracksTextView = true
        movieDescription.text = movie!.desc
        movieTitle.text = movie!.title
        movieRating.text = String(format: "%.0f", movie!.rating * 10) + "%"
        movieImage.sd_setImage(with: URL(string: movie?.photo ?? ""))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.segues.showMovieFacts:
            let controller = segue.destination as? MovieInfoViewController
            controller?.movie = movie
        case Constants.segues.showCastAndCrew:
            let controller = segue.destination as? CastAndCrewViewController
            controller?.movie = movie
        case Constants.segues.showRateItScreen:
            let controller = segue.destination as? UINavigationController
            let tbController = controller?.viewControllers.first as? RateItViewController
            tbController?.movie = movie
        case Constants.segues.showRateImageScreen:
            let controller = segue.destination as? RateImageViewController
            controller?.image = movie?.photo ?? ""
            controller?.screenTitle = movie?.title ?? ""
        case Constants.segues.showReadMoreMovie:
            let controller = segue.destination as? UINavigationController
            let tbController = controller?.viewControllers.first as? ReadMoreViewController
            tbController?.movie = movie
            tbController?.descriptionTitle = keys.descriptionTitle
        default:
            print("No segue")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: keys.reuseIdentifier, for: indexPath as IndexPath) as! CastCollectionCell

        cell.cellSetup(person: self.cast[indexPath.item])
        
        return cell
    }

    private func fetchCastAndCrew(isCast: Bool, movieId: Int) {
        let completion = { (fetchedPeople: [CastAndCrew]) in
            SVProgressHUD.dismiss()
            self.cast = fetchedPeople
            self.castCollectionview.reloadData()
        }

        SVProgressHUD.show()
        MovieManager.fetchCastAndCrew(isCast: isCast, movieId: movieId, completion: completion)
    }

    @IBAction func onPressRate(_ sender: Any) {
        if SessionManager.isLogged() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: keys.rate) as! UINavigationController
            let tbController = vc.viewControllers.first as! RateItViewController
            tbController.movie = movie
            present(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: keys.login) as! UINavigationController
            let tbController = vc.viewControllers.first as! LogInViewController
            tbController.message = Constants.messages.loginToRateMovie
            present(vc, animated: true)
        }
    }

}
