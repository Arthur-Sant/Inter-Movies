//
//  MovieTableViewCell.swift
//  interMovies
//
//  Created by COTEMIG on 07/12/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    private lazy var numberMoviesLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Sora-SemiBold", size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var movieImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var movieNameLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Bold", size: 14)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "orange500")
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
