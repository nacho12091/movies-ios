//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Ignacio Lima on 7/25/19.
//  Copyright © 2019 Ignacio Lima. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieInfoViewController: UIViewController {
    
    private struct arrayKeys {
        static let revenue = "revenue"
        static let budget =  "budget"
        static let runtime = "runtime"
        static let status = "status"
        static let originalLanguage = "original_language"
    }
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var originalLanguage: UILabel!
    
    @IBAction func onPressClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails(id: movie!.movieId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        releaseDate.text = movie?.releaseDate
    }

    private func secondsToHoursMinutesSeconds (seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func fetchMovieDetails(id: Int) {
        let completion = { (fetchedInfo: [String: Any]) in
            SVProgressHUD.dismiss()
            let revenue = fetchedInfo[arrayKeys.revenue] as? Double
            let budget = fetchedInfo[arrayKeys.budget] as? Double
            var runtime = 0
            if (fetchedInfo[arrayKeys.runtime] as? Int != nil) {
                runtime = (fetchedInfo[arrayKeys.runtime] as? Int)!
            }
            let (h, m) = self.secondsToHoursMinutesSeconds(seconds: runtime)
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale.current
            let finalRevenue = currencyFormatter.string(from: NSNumber(value: revenue! / 100))!
            let finalBudget = currencyFormatter.string(from: NSNumber(value: budget! / 100))!
            self.status.text = fetchedInfo[arrayKeys.status] as? String
            self.revenue.text = finalRevenue
            self.budget.text = finalBudget
            self.originalLanguage.text = fetchedInfo[arrayKeys.originalLanguage] as? String
            self.runtime.text = ("\(h)h \(m)m")
        }
        
        SVProgressHUD.show()
        
        MovieManager.getMovieDetails(id: id, completion: completion)
    }

}
