//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    public var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            posterImageView.setImage(with: movie.posterURL)
        }
    }
}
