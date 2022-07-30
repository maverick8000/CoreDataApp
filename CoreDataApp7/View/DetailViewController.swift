//
//  DetailViewController.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/25/22.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var progDetailImageView: UIImageView = {
        
        let detailImageView = UIImageView(frame: .zero)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.contentMode = .scaleAspectFit
        detailImageView.backgroundColor = .black
        detailImageView.layer.cornerRadius = 37.5
        detailImageView.layer.masksToBounds = true
        return detailImageView
        
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .white
        
        label.layer.cornerRadius = 12.5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .white
        
        label.layer.cornerRadius = 12.5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    let imageData: Data
    let artistName: String
    let albumName: String
    
    init(imageData: Data, artistName: String, albumName: String) {
        
        self.imageData = imageData
        self.artistName = artistName
        self.albumName = albumName
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        self.setUpUI()
        self.progDetailImageView.image = UIImage(data: self.imageData)
        self.artistNameLabel.text = self.artistName
        self.albumNameLabel.text = self.albumName
        
    }
    
    private func setUpUI() {
        
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        
        let vStackView2 = UIStackView(frame: .zero)
        vStackView2.translatesAutoresizingMaskIntoConstraints = false
        vStackView2.spacing = 8
        vStackView2.axis = .vertical
        vStackView2.distribution = .fillEqually
        
        let vStackView3 = UIStackView(frame: .zero)
        vStackView3.translatesAutoresizingMaskIntoConstraints = false
        vStackView3.spacing = 8
        vStackView3.axis = .vertical
        vStackView3.distribution = .fillEqually
        
        vStackView2.addArrangedSubview(progDetailImageView)
        vStackView3.addArrangedSubview(artistNameLabel)
        vStackView3.addArrangedSubview(albumNameLabel)
        vStackView.addArrangedSubview(vStackView2)
        vStackView.addArrangedSubview(vStackView3)
        
//        self.view.addSubview(self.progDetailImageView)
//        self.view.addSubview(self.artistNameLabel)
//        self.view.addSubview(self.albumNameLabel)
        
        self.view.addSubview(vStackView)
        
//        self.progDetailImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
//        self.progDetailImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
//        self.progDetailImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//        self.progDetailImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
//        self.progDetailImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
//
//        self.artistNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
//        self.artistNameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
//        self.artistNameLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        self.artistNameLabel.topAnchor.constraint(equalTo: self.progDetailImageView.bottomAnchor, constant: 16).isActive = true
//
//        self.albumNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
//        self.albumNameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
//        self.albumNameLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        self.albumNameLabel.topAnchor.constraint(equalTo: self.artistNameLabel.bottomAnchor, constant: 16).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
    }

}
