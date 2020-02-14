//
//  MovieListRouter.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

// MARK: - MovieListRouterProtocol

class MovieListRouter: MovieListRouterProtocol {
    
    func pushToMovieDetail(with movie: Movie, from view: UIViewController) {
        let movieDetailViewController = view.storyboard?.instantiateViewController(withIdentifier: "MovieDetailView") as! MovieDetailView
        MovieDetailRouter.createMovieDetailModule(with: movieDetailViewController, and: movie)
        view.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    class func createMovieListModule(movieListRef: MovieListView) {
        let presenter: MovieListPresenterProtocol & MovieListOutputInteractorProtocol = MovieListPresenter()
        
        movieListRef.presenter = presenter
        movieListRef.presenter?.router = MovieListRouter()
        movieListRef.presenter?.view = movieListRef
        movieListRef.presenter?.interactor = MovieListInteractor()
        movieListRef.presenter?.interactor?.presenter = presenter
    }
    
}
