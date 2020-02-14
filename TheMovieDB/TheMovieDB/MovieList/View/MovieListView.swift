//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieListView: UIViewController {
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet var movieListCollectionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var retryButton: UIButton!
    
    var presenter:MovieListPresenterProtocol?
    var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.createMovieListModule(movieListRef: self)
        
        movieListCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        loadMovieList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func categoryChanged(_ sender: Any) {
        moveMovieListCollectionViewToTop ()
        loadMovieList()
    }
    
    @IBAction func retryTapped(_ sender: Any) {
        loadMovieList()
    }
    
    private func loadMovieList() {
        activityIndicatorAnimatingView(animating: true)
        hideErrorView()
        
        presenter?.fetchMovieList(with: Constants.category[categorySegmentedControl.selectedSegmentIndex])
        presenter?.getCategoryTitle()
    }
    
    private func activityIndicatorAnimatingView(animating: Bool) {
        animating ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    private func hideErrorView() {
        infoLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    private func showErrorView(_ error: String) {
        infoLabel.text = error
        infoLabel.isHidden = false
        retryButton.isHidden = false
    }
    
    private func moveMovieListCollectionViewToTop () {
        movieListCollectionView.setContentOffset(.zero, animated: true)
    }
}

// MARK: - MovieListViewProtocol
extension MovieListView: MovieListViewProtocol {
    
    func setViewTitle(with title: String?) {
        self.title = title
    }
    
    func reloadView(with movies: [Movie]) {
        activityIndicatorAnimatingView(animating: false)
        movieList = movies
        movieListCollectionView.reloadData()
    }
    
    func showError(with error: String) {
        activityIndicatorAnimatingView(animating: false)
        showErrorView(error)
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        cell.movie = movieList[indexPath.item]
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieSelection(with: movieList[indexPath.item], from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 16) / 2
        let height = width / 2 + width
        return CGSize(width: width, height: height)
    }
    
}

// MARK: - UIScrollViewDelegate

extension MovieListView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(movieListCollectionView.contentOffset.y >= (movieListCollectionView.contentSize.height - movieListCollectionView.bounds.size.height)) {
            presenter?.scrolling()
        }
    }
    
}
