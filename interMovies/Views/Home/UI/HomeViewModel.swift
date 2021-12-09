//
//  HomeViewModel.swift
//  interMovies
//
//  Created by COTEMIG on 08/12/21.
//

import Foundation

protocol HomeViewModelDelegate {
    func updateMoviesData(_ movies: [Movie])
    func showMessageError(_ message: String)
}

class HomeViewModel{
    
    var delegate: HomeViewModelDelegate?

        
    func fetchMovies(){
        let messageError = "falha ao carregar filmes"
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=bb4f90af558fd456bf514be0e8959e89&language=en-US&page=1")
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data, let response = response as? HTTPURLResponse else {
                    self.delegate?.showMessageError(messageError)
                    return
                }
                
                if response.statusCode == 200 {
                    do {
                        let result = try JSONDecoder().decode(Movies.self, from: data)
                        let movies = result.results
                        self.delegate?.updateMoviesData(movies)
                    } catch {
                        self.delegate?.showMessageError(messageError)
                    }
                }
            }.resume()
    }
}
