//
//  RateItViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 8/14/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import Cosmos
import SVProgressHUD

class RateItViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    
    var movie: Movie? = nil
    
    @IBAction func onPressDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressDeleteRate(_ sender: Any) {
        deleteRateValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieName.text = "Rate " + movie!.title
        cosmosView.rating = 0
        fetchMovieStatus(movieId: movie?.movieId ?? 0)
        cosmosView.didFinishTouchingCosmos = { rating in
            self.postRateValue(value: rating)
        }
    }
    
    private func fetchMovieStatus(movieId: Int) {
        let completion = { (rate: Double) in
            let ratedValue = rate / 2
            self.cosmosView.rating = Double(ratedValue)
            SVProgressHUD.dismiss()
        }
        
        SVProgressHUD.show()
        MovieManager.getMovieState(movieId: movieId, completion: completion)
    }
    
    private func postRateValue(value: Double) {
        let completion = { () in
            SVProgressHUD.dismiss()
        }
        
        SVProgressHUD.show()
        MovieManager.postRateValue(movieId: movie?.movieId ?? 0, value: value * 2, completion: completion)
    }

    private func deleteRateValue() {
        let completion = { () in
            self.fetchMovieStatus(movieId: self.movie?.movieId ?? 0)
        }
        
        SVProgressHUD.show()
        MovieManager.deteleRateValue(movieId: movie?.movieId ?? 0, completion: completion)
    }
    
}
