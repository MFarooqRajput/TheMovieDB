//
//  Structs.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import Foundation

public struct Constants {
    static let API_KEY = "fce0e28ab0cacfd2f85e32670ad51b11"
    static let BASE_API_URL = "https://api.themoviedb.org/3"
    static let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/"
    
    static let category: [Category] = [.nowPlaying, .popular, .upcoming, .topRated]
}
