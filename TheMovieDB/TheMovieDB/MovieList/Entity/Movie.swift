//
//  Movie.swift
//  TheMovieDB
//
//  Created by Muhammmad Farooq on 11/02/2020.
//  Copyright © 2020 Muhammmad Farooq. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

public struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let voteCount: Int
    public let tagline: String?
    public let genres: [MovieGenre]?
    public let videos: MovieVideoResponse?
    public let credits: MovieCreditResponse?
    public let adult: Bool
    public let runtime: Int?
    public var posterURL: URL {
        return URL(string: "\(Constants.BASE_IMAGE_URL)w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "\(Constants.BASE_IMAGE_URL)original\(backdropPath ?? "")")!
    }
    
    public var voteAveragePercentText: String {
        return "\(Int(voteAverage * 10))%"
    }
    
}

public struct MovieGenre: Codable {
    let name: String
}

public struct MovieVideoResponse: Codable {
    public let results: [MovieVideo]
}

public struct MovieVideo: Codable {
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}

public struct MovieCreditResponse: Codable {
    public let cast: [MovieCast]
    public let crew: [MovieCrew]
}

public struct MovieCast: Codable {
    public let character: String
    public let name: String
}

public struct MovieCrew: Codable {
    public let id: Int
    public let department: String
    public let job: String
    public let name: String
}
