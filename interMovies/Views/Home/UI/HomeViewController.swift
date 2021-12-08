//
//  HomeViewController.swift
//  interMovies
//
//  Created by COTEMIG on 07/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Components
    
    private lazy var backBtnBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "arrowleft")
        button.tintColor = .white
        button.action = #selector(backToSplash)
        button.target = self
        return button
    }()
    
    private lazy var titleBar: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Sora-SemiBold", size: 16)
        label.textColor = .white
        label.text = "Inter Movies"
        return label
    }()
    
    private lazy var themeBtnBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "theme")
        button.tintColor = .white
        return button
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        return tableView
    }()
    
    //MARK: UI

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    var movies: [Movie] = []
    var filterMovies: [Movie] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String){
        filterMovies = movies.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        
    }
    
    @objc func backToSplash(){
        navigationController?.popViewController(animated: true)
    }
    
    func setup(){
        setupUI()
    }
    
    func setupUI(){
        let gray500 = UIColor(named: "gray500")
        view.backgroundColor = gray500
        setupUINav(color: gray500!)
        setupUISearch()
    }
    
    func setupUINav(color gray500: UIColor){
        navigationController?.navigationBar.isHidden = false
        
        let navItem = navigationController?.navigationBar.standardAppearance
        navItem?.backgroundColor = gray500
        navItem?.shadowColor = gray500
        
        navigationItem.leftBarButtonItem = backBtnBar
        navigationItem.rightBarButtonItem = themeBtnBar
        navigationItem.titleView = titleBar
    }
    
    func setupUISearch(){
        let searchBar = searchController.searchBar
        let textFiled = searchBar.searchTextField
        var attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .white]
        textFiled.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes:attributes)
        textFiled.backgroundColor = UIColor(named: "gray400")
        searchBar.tintColor = .orange
        searchBar.searchTextField.textColor = .white
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText!)
    }
}

