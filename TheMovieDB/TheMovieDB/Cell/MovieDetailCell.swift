//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    public static var nib: UINib {
        return UINib(nibName: "MovieDetailCell", bundle: Bundle(for: MovieDetailCell.self))
    }
    
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter
    }()
    
    public var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            taglineLabel.text = movie.tagline
            overviewLabel.text = movie.overview
            yearLabel.text = MovieDetailCell.dateFormatter.string(from: movie.releaseDate)
            if movie.voteCount == 0 {
                ratingLabel.isHidden = true
            } else {
                ratingLabel.isHidden = false
                ratingLabel.text = movie.voteAveragePercentText
            }
            
            adultLabel.isHidden = !movie.adult
            
            durationLabel.text = "\(movie.runtime ?? 0) mins"
            if let genres = movie.genres, genres.count > 0 {
                genreLabel.isHidden = false
                genreLabel.text = genres.map { $0.name }.joined(separator: ", ")
            } else {
                genreLabel.isHidden = true
            }
            
            if let casts = movie.credits?.cast, casts.count > 0 {
                castLabel.isHidden = false
                if casts.count > 1 {
                    castLabel.text = "Cast: \(casts.prefix(upTo: 3).map { $0.name }.joined(separator: ", "))"
                } else {
                    castLabel.text = "Cast: \(casts.prefix(upTo: 1).map { $0.name }.joined(separator: ", "))"
                }
            } else {
                castLabel.isHidden = true
            }
            
            if let director = movie.credits?.crew.first(where: {$0.job == "Director"}) {
                crewLabel.isHidden = false
                crewLabel.text = "Director: \(director.name)"
            } else {
                crewLabel.isHidden = true
            }
            
        }
    }
}
