//
//  MovieListInteractor.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieListInteractor {
    
    weak var presenter: MovieListOutputInteractorProtocol?
    var movieService: MovieService = MovieStore.shared
    
    private func fetchMovies(with category: Category, isScrolling: Bool) {
        
        let pageKey = category.description + "page"
        let totalPagesKey = category.description + "totalpage"
        let moviesKey = category.description + "movie"
        
        var page = UserDefaults.standard.integer(forKey: pageKey)
        var totalPages = UserDefaults.standard.integer(forKey: totalPagesKey)
        
        var movieArray = [Movie]()
        if page == 0 {
            page += 1
        } else {
            guard  let movieData = UserDefaults.standard.data(forKey: moviesKey) else {
                return
            }
            movieArray = try! JSONDecoder().decode([Movie].self, from: movieData)
            
            if isScrolling && page < totalPages {
                page += 1
            } else {
                if movieArray.isEmpty {
                    presenter?.movieListDidFetch(with: "No movie found, please retry")
                }
                
                presenter?.movieListDidFetch(with: movieArray)
                return
            }
        }
        
        var params: [String: String] = [:]
        params["page"] = String(page)
        
        movieService.fetchMovies(from: category, params: params, successHandler: { [unowned self] (response) in
            totalPages = response.totalPages
            movieArray += response.results
            if movieArray.isEmpty {
                self.presenter?.movieListDidFetch(with: movieArray)
                self.presenter?.movieListDidFetch(with: "No movie found, please retry")
            } else {
                
                UserDefaults.standard.set(page, forKey: pageKey)
                UserDefaults.standard.set(totalPages, forKey: totalPagesKey)
                
                let moviesData = try! JSONEncoder().encode(movieArray)
                UserDefaults.standard.set(moviesData, forKey: moviesKey)
                
                self.presenter?.movieListDidFetch(with: movieArray)
            }
        }) { [unowned self] (error) in
            self.presenter?.movieListDidFetch(with: movieArray)
            self.presenter?.movieListDidFetch(with: error.localizedDescription)
        }
        
    }
}

// MARK: - MovieListInputInteractorProtocol
extension MovieListInteractor: MovieListInputInteractorProtocol {
    
    func getMovieList(with category: Category, isScrolling: Bool) {
        fetchMovies(with: category, isScrolling: isScrolling)
    }
}



