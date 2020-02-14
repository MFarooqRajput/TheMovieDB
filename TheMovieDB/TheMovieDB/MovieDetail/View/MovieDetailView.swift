//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 12/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import UIKit

class MovieDetailView: UIViewController {
    
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var movieDetailTableView: UITableView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var retryButton: UIButton!
    
    var presenter: MovieDetailPresenterProtocol?
    
    var movie: Movie! {
        didSet {
            updateMovieDetail()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailTableView.register(MovieDetailCell.nib, forCellReuseIdentifier: "DetailCell")
        
        activityIndicatorAnimatingView(animating: true)
        hideErrorView()
        
        presenter?.viewDidLoad()
        presenter?.fetchMovieDetail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func updateMovieDetail() {
        titleLabel.text = movie.title
        backdropImageView.setImage(with: movie.backdropURL, placeHolder: #imageLiteral(resourceName: "film-placeholder"))
        posterImageView.setImage(with: movie.posterURL)
        
        movieDetailTableView.reloadData()
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
    
    @IBAction func retryTapped(_ sender: Any) {
        presenter?.fetchMovieDetail()
    }
}

// MARK: - MovieDetailViewProtocol

extension MovieDetailView: MovieDetailViewProtocol {
    
    func reloadView(with movie: Movie) {
        activityIndicatorAnimatingView(animating: false)
        self.movie = movie
    }
    
    func showError(with error: String) {
        activityIndicatorAnimatingView(animating: false)
        showErrorView(error)
    }
    
    func showMovieDetail(with movie: Movie) {
        self.movie = movie
    }
    
}

// MARK: - UITableViewDataSource

extension MovieDetailView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movie == nil ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : movie?.videos?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! MovieDetailCell
            cell.movie = movie
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let video = (movie?.videos?.results ?? [])[indexPath.row]
            cell.textLabel?.text = video.name
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension MovieDetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Trailers"
        }
        return nil
    }
    
}
