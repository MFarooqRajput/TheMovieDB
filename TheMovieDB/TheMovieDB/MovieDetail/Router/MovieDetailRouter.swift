//
//  MovieDetailRouter.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 12/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    class func createMovieDetailModule(with movieDetailRef: MovieDetailView, and movie: Movie) {
        let presenter = MovieDetailPresenter()
        presenter.movie = movie
        movieDetailRef.presenter = presenter
        movieDetailRef.presenter?.view = movieDetailRef
        movieDetailRef.presenter?.router = MovieDetailRouter()
        
        movieDetailRef.presenter?.interactor = MovieDetailInteractor()
        movieDetailRef.presenter?.interactor?.presenter = presenter
    }
    
    func goBackToMovieListView(from view: UIViewController) {
        
    }
    
    deinit {
        debugPrint("MovieDetailRouter removed")
    }
}
