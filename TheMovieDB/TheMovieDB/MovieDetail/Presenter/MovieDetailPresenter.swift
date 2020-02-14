//
//  MovieDetailPresenter.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 12/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieDetailPresenter {
    var router: MovieDetailRouterProtocol?
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInputInteractorProtocol?
    var movie: Movie?
    
    deinit {
        print("MovieDetailPresenter removed")
    }
}

// MARK: - MovieDetailPresenterProtocol

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.showMovieDetail(with: movie!)
    }
    
    func backButtonPressed(from view: UIViewController) {
        
    }
    
    func fetchMovieDetail() {
        guard let movie = movie else {
            return
        }
        
        interactor?.getMovieDetail(with: movie.id)
    }
}

// MARK: - MovieDetailOutputInteractorProtocol

extension MovieDetailPresenter: MovieDetailOutputInteractorProtocol {
    
    func movieDetailDidFetch(with movie: Movie) {
        view?.reloadView(with: movie)
    }
    
    func movieDetailDidFetch(with erorr: String) {
        view?.showError(with: erorr)
    }
}
