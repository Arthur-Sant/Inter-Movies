//
//  MovieTableViewCell.swift
//  interMovies
//
//  Created by COTEMIG on 07/12/21.
//

import UIKit
import Kingfisher
//aplicar no Swift Package: https://github.com/onevcat/Kingfisher.git
import Fakery
// aplicar no Swift Package: https://github.com/vadymmarkov/Fakery

class MovieTableViewCell: UITableViewCell {
    
    public static let identifier = "movieCell"
    
    private lazy var numberMoviesLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Sora-SemiBold", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieNameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 14)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange500")
        return label
    }()
    
    private lazy var categoriesStv: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var movieDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular", size: 10)
        label.textColor = .gray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var favoriteImg: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var favorites = UserDefaults.standard.value(forKey: "favorites") as? [Int]
    var faker = Faker()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(numberMoviesLbl)
        contentView.addSubview(movieImg)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(movieNameLbl)
        stackView.addArrangedSubview(categoriesStv)
        stackView.addArrangedSubview(movieDate)
        contentView.addSubview(favoriteImg)
        
        setupLayout()
    }
    
    func configureCell(movie: Movie, movieNumber: String){
        contentView.backgroundColor = UIColor(named: "gray500")
        numberMoviesLbl.text = movieNumber
        let urlImg = URL(string: "https://image.tmdb.org/t/p/w400\(movie.posterPath)")
        movieImg.kf.setImage(with: urlImg)
        movieNameLbl.text = movie.title
        movieDate.text = movie.releaseDate
        
        var i = 0
        while i < 3 {
            let label = UILabel()
            label.font = UIFont(name: "Inter-Bold", size: 12)
            label.textColor = .white
            label.text = faker.name.name()
            categoriesStv.addArrangedSubview(label)
            
            i += 1
        }
        
        if favorites != nil && favorites!.contains(movie.id){
            favoriteImg.image = UIImage(systemName: "heart.fill")
        }else{
            favoriteImg.image = UIImage(systemName: "heart")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoriesStv = UIStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            numberMoviesLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            numberMoviesLbl.centerYAnchor.constraint(equalTo: movieImg.centerYAnchor),
            numberMoviesLbl.widthAnchor.constraint(equalToConstant: 17),
            
            movieImg.heightAnchor.constraint(equalToConstant: 120),
            movieImg.widthAnchor.constraint(equalToConstant: 80),
            movieImg.leftAnchor.constraint(equalTo: numberMoviesLbl.rightAnchor, constant: 8),
            movieImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            favoriteImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            favoriteImg.centerYAnchor.constraint(equalTo: movieImg.centerYAnchor),
            favoriteImg.heightAnchor.constraint(equalToConstant: 24),
            favoriteImg.widthAnchor.constraint(equalToConstant: 24),
            
            stackView.topAnchor.constraint(equalTo: movieImg.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: movieImg.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: movieImg.rightAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: favoriteImg.leftAnchor, constant: -16)
        ])
        
    }
}
