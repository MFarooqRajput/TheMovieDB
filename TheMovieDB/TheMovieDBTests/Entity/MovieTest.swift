//
//  MovieTest.swift
//  TheMovieDBTests
//
//  Created by Muhammmad Farooq on 14/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class MovieEntityTests: XCTestCase {
    
    func testMovie() {
        
        let movie = Movie(id: 419704, title: "Ad Astra", backdropPath: "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg", posterPath: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.", releaseDate: Date(), voteAverage: 6.1, voteCount: 1340, tagline: nil, genres: nil, videos: nil, credits: nil, adult: false, runtime: nil)
        
        XCTAssertEqual(movie.id, 419704)
        XCTAssertEqual(movie.title, "Ad Astra")
        XCTAssertNil(movie.genres)
        XCTAssertFalse(movie.adult)
    }
}
