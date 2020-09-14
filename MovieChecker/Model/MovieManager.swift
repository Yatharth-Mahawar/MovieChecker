//
//  MovieManager.swift
//  MovieChecker
//
//  Created by Yatharth Mahawar on 18/08/20.
//  Copyright © 2020 Yatharth Mahawar. All rights reserved.
//

import Foundation


protocol MovieManagerDelegate {
    func dipUpdateMovie(movie:MovieDataModel)
}

struct MovieManager {
    
    let weatherurl = ""
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovieData(movieName:String){
        let urlString = "\(weatherurl)&t=\(movieName)"
        let url = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print(url)
        performRequest(urlString: url!)
        
    }
    
    
    
    func performRequest(urlString:String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, urlstring, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data{
                    if let movie = self.parseJSON(MovieDat: safeData) {
                        self.delegate?.dipUpdateMovie(movie: movie)
                        
                    }
                    
                }
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(MovieDat:Data) -> MovieDataModel?{
        let decoder = JSONDecoder()
        do { let decoderData = try decoder.decode(MovieData.self, from: MovieDat)
            let movieName = decoderData.Title
            let moviePlot  = decoderData.Plot
            let moivePoster = decoderData.Poster
            let movieRating = decoderData.imdbRating
            let movieDataFinal = MovieDataModel(movieTitle: movieName, movieDescription: moviePlot,moviePoster:moivePoster,movieRating:movieRating)
            
            return movieDataFinal
            
            
            
        }
        catch{
            print(error)
            return nil
        }
    }
    
    
    
}
