//
//  MovieListProtocols.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

protocol MovieListPresenterProtocol: class {
    
    var interactor: MovieListInputInteractorProtocol? {get set}
    var view: MovieListViewProtocol? {get set}
    var router: MovieListRouterProtocol? {get set}
    
    //View -> Presenter
    func fetchMovieList(with category: Category)
    func scrolling()
    func getCategoryTitle()
    func showMovieSelection(with movie: Movie, from view: UIViewController)
}

protocol MovieListInputInteractorProtocol: class {
    
    var presenter: MovieListOutputInteractorProtocol? {get set}
    
    //Presenter -> Interactor
    func getMovieList(with category: Category, isScrolling: Bool)
}

protocol MovieListOutputInteractorProtocol: class {
    
    //Interactor -> Presenter
    func movieListDidFetch(with movieList: [Movie])
    func movieListDidFetch(with erorr: String)
}

protocol MovieListViewProtocol: class {
    
    // Presenter -> View
    func setViewTitle(with title: String?)
    func reloadView(with movies: [Movie])
    func showError(with error: String)
}

protocol MovieListRouterProtocol: class {
    
    //Presenter -> Router
    func pushToMovieDetail(with movie: Movie,from view: UIViewController)
    static func createMovieListModule(movieListRef: MovieListView)
}
