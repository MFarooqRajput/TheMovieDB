//
//  MovieDetailProtocols.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 12/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterProtocol: class {
    
    var interactor: MovieDetailInputInteractorProtocol? {get set}
    var router: MovieDetailRouterProtocol? {get set}
    var view: MovieDetailViewProtocol? {get set}
    
    //View -> Presenter
    func viewDidLoad()
    func backButtonPressed(from view: UIViewController)
    func fetchMovieDetail()
}

protocol MovieDetailInputInteractorProtocol: class {
    
    var presenter: MovieDetailOutputInteractorProtocol? {get set}
    
    //Presenter -> Interactor
    func getMovieDetail(with movieId: Int)
}

protocol MovieDetailOutputInteractorProtocol: class {
    
    //Interactor -> Presenter
    func movieDetailDidFetch(with movie: Movie)
    func movieDetailDidFetch(with erorr: String)
}

protocol MovieDetailViewProtocol: class {
    
    //Presenter -> View
    func showMovieDetail(with movie: Movie)
    func reloadView(with movie: Movie)
    func showError(with error: String)
}

protocol MovieDetailRouterProtocol: class {
    
    //Presenter -> Router
    func goBackToMovieListView(from view: UIViewController)
}

