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
    
    private lazy var backBtnBar: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrowleft"), for: .normal)
        button.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private lazy var favoriteBtnBar: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(addFavoriteOrRemove), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.size.width,
            height: 260
        )
        return view
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
        label.font = UIFont(name: "Inter-Bold", size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1
        label.backgroundColor = .systemGreen
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 14)
        label.textColor = .white
        return label
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
    
        viewModel = MovieDetailViewModel()
        viewModel?.delegate = self
        viewModel?.checkIfFavorite(movieId: movie.id)
        
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    var movie: Movie
    var viewModel: MovieDetailViewModel?
    var favorite: Bool?
    
    init(movie: Movie) {
        self.movie = movie
        favorite = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addFavoriteOrRemove(){
        viewModel?.addFavoritesOrRemove(movieId: movie.id, add: favorite!)
    }
    
    func setup(){
        buildViewHierarchy()
        setupUI()
        setDataMovie()
        setupLayout()
    }
    
    func buildViewHierarchy(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImg)
        contentView.addSubview(gradientView)
        contentView.addSubview(backBtnBar)
        contentView.addSubview(favoriteBtnBar)
        contentView.addSubview(movieNameLBl)
        contentView.addSubview(stackView)
        contentView.addSubview(movieYearTimeLbl)
        contentView.addSubview(movieSynopsisLbl)
        contentView.addSubview(movieSynopsisTextLbl)
        contentView.addSubview(firstPartStv)
        contentView.addSubview(secondPartStv)
        contentView.addSubview(watchBtn)

    }
    
    func setupUI(){
        view.backgroundColor = UIColor(named: "gray500")

        navigationController?.navigationBar.isHidden = true
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
        ])

        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentViewHeight
        ])

        NSLayoutConstraint.activate([
            
            movieImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImg.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            movieImg.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            movieImg.heightAnchor.constraint(equalToConstant: 260),
            
            backBtnBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            backBtnBar.topAnchor.constraint(equalTo: movieImg.topAnchor, constant: 24),
            backBtnBar.widthAnchor.constraint(equalToConstant: 30),
            backBtnBar.heightAnchor.constraint(equalToConstant: 30),
            
            favoriteBtnBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            favoriteBtnBar.topAnchor.constraint(equalTo: movieImg.topAnchor, constant: 24),
            favoriteBtnBar.widthAnchor.constraint(equalToConstant: 30),
            favoriteBtnBar.heightAnchor.constraint(equalToConstant: 30),
            
            movieNameLBl.topAnchor.constraint(equalTo: movieImg.bottomAnchor, constant: -16),
            movieNameLBl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieNameLBl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: movieNameLBl.bottomAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            movieAgeLbl.heightAnchor.constraint(equalToConstant: 19),
            movieAgeLbl.widthAnchor.constraint(equalToConstant: 22),
            
            movieVoteLbl.heightAnchor.constraint(equalToConstant: 19),
            movieVoteLbl.widthAnchor.constraint(equalToConstant: 40),
            
            movieYearTimeLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieYearTimeLbl.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            
            movieSynopsisLbl.topAnchor.constraint(equalTo: movieYearTimeLbl.bottomAnchor, constant: 64),
            movieSynopsisLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            movieSynopsisTextLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieSynopsisTextLbl.topAnchor.constraint(equalTo: movieSynopsisLbl.bottomAnchor, constant: 16),
            movieSynopsisTextLbl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            firstPartStv.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            firstPartStv.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            firstPartStv.topAnchor.constraint(equalTo: movieSynopsisTextLbl.bottomAnchor, constant: 24),
            
            secondPartStv.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            secondPartStv.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            secondPartStv.topAnchor.constraint(equalTo: firstPartStv.bottomAnchor, constant: 16),
            
            watchBtn.topAnchor.constraint(greaterThanOrEqualTo: secondPartStv.bottomAnchor, constant: 48),
            watchBtn.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            watchBtn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            watchBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            watchBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setDataMovie(){
        let urlImg = URL(string: "https://image.tmdb.org/t/p/w400\(movie.backdropPath)")!
        movieImg.kf.setImage(with: urlImg)
        
        let gradient = CAGradientLayer()
        let gray500 = UIColor(named: "gray500")!.cgColor
        gradient.colors = [gray500, UIColor.clear.cgColor, gray500]
        gradient.frame = gradientView.bounds
        gradientView.layer.addSublayer(gradient)
        
        movieNameLBl.text = movie.title
        
        if movie.adult {
            movieAgeLbl.text = "18"
        }else{
            movieAgeLbl.text = "12"
        }
        stackView.addArrangedSubview(movieAgeLbl)
        
        let faker = Faker()
        
        for _ in 0..<3 {
            let label = UILabel()
            label.font = UIFont(name: "Inter-Bold", size: 12)
            label.textColor = .white
            label.text = faker.lorem.word()
            stackView.addArrangedSubview(label)
        }
        
        movieVoteLbl.text = "\(movie.voteAverage)%"
        stackView.addArrangedSubview(movieVoteLbl)
        
        movieYearTimeLbl.text = "\(movie.releaseDate.prefix(4)) - 3h e 42 minutos"
        
        movieSynopsisTextLbl.text = movie.overview
        
        for _ in 0..<2 {
            var moviePeopleStv = UIStackView()
            moviePeopleStv.axis = .vertical
            
            var name = UILabel()
            name.font = UIFont(name: "Inter-Bold", size: 14)
            name.textColor = .white
            name.text = faker.name.name()
            
            var profession = UILabel()
            profession.textColor = .gray
            profession.font = UIFont(name: "Inter-Regular", size: 12)
            profession.text = faker.lorem.word()
            
            moviePeopleStv.addArrangedSubview(name)
            moviePeopleStv.addArrangedSubview(profession)
            firstPartStv.addArrangedSubview(moviePeopleStv)
            
            moviePeopleStv = UIStackView()
            moviePeopleStv.axis = .vertical
            
            name = UILabel()
            name.font = UIFont(name: "Inter-Bold", size: 14)
            name.textColor = .white
            name.text = faker.name.name()
            
            profession = UILabel()
            profession.textColor = .gray
            profession.font = UIFont(name: "Inter-Regular", size: 12)
            profession.text = faker.lorem.word()
            
            moviePeopleStv.addArrangedSubview(name)
            moviePeopleStv.addArrangedSubview(profession)
            secondPartStv.addArrangedSubview(moviePeopleStv)
        }
    }

}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func didSetImagefavoriteBtn(_ response: Bool) {
        self.favorite = !response
        
        if response {
            favoriteBtnBar.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoriteBtnBar.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Mensagem", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
