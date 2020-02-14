//
//  MovieListPresenter.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieListPresenter {
    
    var router: MovieListRouterProtocol?
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInputInteractorProtocol?
    
    var category: Category?
    var isPageRefreshing:Bool = false
    
    private func fetchMovieList(isScrolling: Bool = false) {
        guard let category = category else {
            return
        }
        
        interactor?.getMovieList(with: category, isScrolling: isScrolling)
    }
}

// MARK: - MovieListPresenterProtocol

extension MovieListPresenter: MovieListPresenterProtocol {
    
    func fetchMovieList(with category: Category) {
        self.category = category
        fetchMovieList()
    }
    
    func getCategoryTitle() {
        view?.setViewTitle(with: category?.description)
    }
    
    func scrolling() {
        if !isPageRefreshing {
            isPageRefreshing = true
            fetchMovieList(isScrolling: true)
        }
    }
    
    func showMovieSelection(with movie: Movie, from view: UIViewController) {
        router?.pushToMovieDetail(with: movie, from: view)
    }
}

// MARK: - MovieListOutputInteractorProtocol

extension MovieListPresenter: MovieListOutputInteractorProtocol {
    
    func movieListDidFetch(with movieList: [Movie]) {
        isPageRefreshing = false
        view?.reloadView(with: movieList)
    }
    
    func movieListDidFetch(with erorr: String) {
        isPageRefreshing = false
        view?.showError(with: erorr)
    }
    
}
