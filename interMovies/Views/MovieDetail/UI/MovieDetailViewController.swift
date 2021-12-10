//
//  MovieDetailViewController.swift
//  interMovies
//
//  Created by COTEMIG on 08/12/21.
//

import UIKit
import Fakery
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    private lazy var backBtnBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.image = UIImage(named: "arrowleft")
        button.tintColor = .white
        button.action = #selector(backToHome)
        return button
    }()
    
    private lazy var favoriteBtnBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.tintColor = .white
//        button.action = #selector()
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "gray500")
        return view
    }()
    
    private lazy var movieImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieNameLBl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Sora-SemiBold", size: 24)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var movieAgeLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.cornerRadius = 4
        return label
    }()
    
    private lazy var movieVoteLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .green
        label.layer.cornerRadius = 4
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()

    private lazy var movieYearTimeLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieSynopsisLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Sora-SemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Sinopse"
        return label
    }()
    
    private lazy var movieSynopsisTextLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.textColor = .gray
        return label
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var profession: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Inter-Regular", size: 12)
        return label
    }()
    
    private lazy var moviePeopleStv: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var firstPartStv: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var secondPartStv: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var watchBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Assistir", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Bold", size: 14)
        button.backgroundColor = UIColor(named: "orange500")
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel?.delegate = self
        view.addSubview(movieImg)
        let url = URL(string: "https://image.tmdb.org/t/p/w400\(movie.backdropPath)")!
        movieImg.kf.setImage(with: url)
        setup()
    }
    
    var movie: Movie
    var viewModel: MovieDetailViewModel?
    
    init(movie: Movie) {
        self.movie = movie
        viewModel = MovieDetailViewModel()
        viewModel?.checkIfFavorite(movieId: movie.id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    func setup(){
        setupUI()
        setupLayout()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(named: "gray500")
        
        navigationItem.leftBarButtonItem = backBtnBar
        navigationItem.rightBarButtonItem = favoriteBtnBar
    }
    
    func setupLayout(){

        NSLayoutConstraint.activate([
            movieImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImg.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieImg.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func didSetImagefavoriteBtn(_ response: Bool) {
        
    }
    
    func showMessage(_ message: String) {
        
    }
}
