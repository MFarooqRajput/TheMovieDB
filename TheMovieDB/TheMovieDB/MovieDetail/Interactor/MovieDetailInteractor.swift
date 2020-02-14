//
//  MovieDetailInteractor.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 13/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieDetailInteractor {
    weak var presenter: MovieDetailOutputInteractorProtocol?
    var movieService: MovieService = MovieStore.shared
    
    private func fetchMovieDetail(movieId: Int) {
        movieService.fetchMovie(id: movieId, successHandler: {[unowned self] (movie) in
            self.presenter?.movieDetailDidFetch(with: movie)
        }) { [unowned self] (error) in
            self.presenter?.movieDetailDidFetch(with: error.localizedDescription)
        }
    }
}

// MARK: - MovieDetailInputInteractorProtocol

extension MovieDetailInteractor: MovieDetailInputInteractorProtocol {
    
    func getMovieDetail(with movieId: Int) {
        fetchMovieDetail(movieId: movieId)
    }
}
