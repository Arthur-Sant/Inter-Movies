//
//  ViewController.swift
//  interMovies
//
//  Created by COTEMIG on 07/12/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    //MARK: Components
    
    private lazy var movieImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "movie")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var interLbl: UILabel = {
        let label = UILabel()
        label.text = "inter"
        label.textAlignment = .right
        label.font = UIFont(name: "Sora-ExtraBold", size: 35)
        label.textColor = UIColor(named: "orange500")
        return label
    }()
    
    private lazy var moviesLbl: UILabel = {
        let label = UILabel()
        label.text = "movies"
        label.font = UIFont(name: "Sora-ExtraBold", size: 35)
        label.textColor = .gray
        return label
    }()
    
    private lazy var descriptionLbl: UILabel = {
        let label = UILabel()
        label.text = """
            Milhões de filmes e séries para descobrir.
            Esperimente por 7 dias.
            """
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Sora-ExtraBold", size: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var exploreBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Explore já", for: .normal)
        button.backgroundColor = UIColor(named: "orange500")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "Inter-Bold", size: 14)
        button.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logoStv: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func goToHome(){
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    func setup(){
        setupUI()
        buildViewHierarchy()
        setupLayout()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(named: "gray500")
    }
    
    func buildViewHierarchy() {
        view.addSubview(movieImg)
        view.addSubview(stackView)
        stackView.addArrangedSubview(logoStv)
        logoStv.addArrangedSubview(interLbl)
        logoStv.addArrangedSubview(moviesLbl)
        stackView.addArrangedSubview(descriptionLbl)
        view.addSubview(exploreBtn)
        
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            
            movieImg.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -33),
            movieImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImg.heightAnchor.constraint(equalToConstant: 54),
            movieImg.widthAnchor.constraint(equalToConstant: 54),
            
            exploreBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            exploreBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreBtn.heightAnchor.constraint(equalToConstant: 50),
            exploreBtn.widthAnchor.constraint(equalToConstant: 115)
        ])
    }

}

