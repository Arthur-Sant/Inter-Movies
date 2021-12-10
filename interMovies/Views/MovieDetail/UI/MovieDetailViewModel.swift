//
//  MovieDetailViewModel.swift
//  interMovies
//
//  Created by COTEMIG on 09/12/21.
//

import UIKit

protocol MovieDetailViewModelDelegate {
    func didSetImagefavoriteBtn(_ response: Bool)
    func showMessage(_ message: String)
}

class MovieDetailViewModel {
    var delegate: MovieDetailViewModelDelegate?
    
    let userDefaults = UserDefaults.standard
    var favorites = [Int]()
    
    func checkIfFavorite(movieId id: Int){
        favorites = userDefaults.value(forKey: "favorites") as? [Int] ?? []
        
        if favorites.contains(id){
            delegate?.didSetImagefavoriteBtn(true)
        }else{
            delegate?.didSetImagefavoriteBtn(false)
        }
    }
    
    func addFavoritesOrRemove(movieId id: Int, add: Bool){
        
        var message = ""
        
        if add {
            favorites.append(id)
            message = "Filme adicionado na lista de favoritos"
        }else{
            favorites = favorites.filter { $0 != id }
            message = "Filme removido da lista de favoritos"
        }
        userDefaults.setValue(favorites, forKey: "favorites")
        
        delegate?.showMessage(message)
        checkIfFavorite(movieId: id)
    }
}
