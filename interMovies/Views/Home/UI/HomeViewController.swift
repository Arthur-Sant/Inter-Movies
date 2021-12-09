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
    
    private lazy var popularLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Sora-SemiBold", size: 16)
        label.text = "Os mais populares"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showAllLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = UIColor(named: "orange500")
        label.text = "Ver todos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "gray500")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: UI
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        viewModel = HomeViewModel()

        setup()
        
        viewModel?.delegate = self
        
        viewModel?.fetchMovies()
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
        
        moviesTableView.reloadData()
    }
    
    @objc func backToSplash(){
        navigationController?.popViewController(animated: true)
    }
    
    func setup(){
        setupUI()
        buildViewHierarchy()
        setupLayout()
    }
    
    func buildViewHierarchy(){
        view.addSubview(popularLbl)
        view.addSubview(showAllLbl)
        view.addSubview(moviesTableView)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            popularLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            popularLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            showAllLbl.bottomAnchor.constraint(equalTo: popularLbl.bottomAnchor),
            showAllLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            moviesTableView.topAnchor.constraint(equalTo: popularLbl.bottomAnchor, constant: 8),
            moviesTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            moviesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .white]
        textFiled.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes:attributes)
        textFiled.backgroundColor = UIColor(named: "gray400")
        searchBar.tintColor = .orange
        searchBar.barStyle = .black
        
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

//MARK: TableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterMovies.count
        }
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieTableViewCell.identifier,
                for: indexPath
        ) as? MovieTableViewCell
        else {
            return UITableViewCell()
        }
        
        let movie: Movie
        
        if isFiltering {
            movie = filterMovies[indexPath.row]
        }else{
            movie = movies[indexPath.row]
        }
        
        cell.configureCell(movie: movie, movieNumber: String(indexPath.row + 1))
    
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie
        if isFiltering {
            movie = filterMovies[indexPath.row]
        }else{
            movie = movies[indexPath.row]
        }
        
        navigationController?.pushViewController(MovieDetailViewController(movie: movie), animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func updateMoviesData(_ movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
    
    func showMessageError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

