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

protocol MovieDetailCellDelagate {
    func updateCell()
}

class MovieDetailViewModel {
    var delegate: MovieDetailViewModelDelegate?
    var cellDegalate: MovieDetailCellDelagate?
    
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
        
        if add {
            favorites.append(id)
        }else{
            let newfavorites = favorites.filter { $0 != id }
            userDefaults.setValue(newfavorites, forKey: "favorites")
        }
        
        cellDegalate?.updateCell()
    }
}
