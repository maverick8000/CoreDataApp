//
//  AlbumTableViewCell.swift
//  CoreDataApp7
//
//  Created by Raul Barranco on 7/25/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    static let reuseId = "\(AlbumTableViewCell.self)"
    
    //let text: String = "Like me"
    
    let albumVM: AlbumViewModel = AlbumViewModel(networkManager: NetworkManager())
    var albumImage: Data?
    var artistName: String?
    var albumName: String?
    var swapFavorite: Bool = false

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "albumDefaultIcon")
        imageView.layer.cornerRadius = 25.0
        return imageView
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Album Artist Name"
        //label.backgroundColor = .magenta
        //label.layer.cornerRadius = 12
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Here goes the Album's Title"
        //label.backgroundColor = .green
        //label.layer.cornerRadius = 12
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var progButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to favorites", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        button.backgroundColor = UIColorFromRGB(rgbValue: 0xFFF0F5)
        button.addTarget(self, action: #selector(self.progButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.tapMeAnimatedButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var progButton2: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete from favorites", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        
        button.backgroundColor = UIColorFromRGB(rgbValue: 0xE0E0E0)
        button.addTarget(self, action: #selector(self.progButtonPressed2), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.tapMeAnimatedButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    /* ############################################################################################################################## */
    
//    @objc
//    func progButtonPressed() {
//
//        print("Favorite Button tapped!!!")
//        self.swapFavorite = !swapFavorite
//        if swapFavorite
//        {
//            self.progButton.backgroundColor = .magenta
//        }
//        else
//        {
//            self.progButton.backgroundColor = UIColorFromRGB(rgbValue: 0xFFF0F5)
//        }
//
//        self.albumVM.makeMusicAlbum(albumImage: self.albumImage!, artistName: self.artistName!)
//
//    }
    
    @objc
    func progButtonPressed() {
        
//        print("Favorite Button tapped!!!")
//        self.swapFavorite = !swapFavorite
//        if swapFavorite
//        {
//            self.progButton.backgroundColor = .magenta
//            self.albumVM.makeMusicAlbum(albumImage: self.albumImage!, artistName: self.artistName!)
//        }
//        else
//        {
//            self.progButton.backgroundColor = UIColorFromRGB(rgbValue: 0xFFF0F5)
//            self.albumVM.deleteAlbum()
//        }
    
        //self.albumVM.deleteAlbum()
        //self.albumVM.deleteAll()
        
        print("Favorite Button tapped!!!")
        
        self.progButton.backgroundColor = .magenta
        
        let myImage = UIImage(named: "albumDefaultIcon")
        let myData: Data = myImage!.pngData()!
        self.albumVM.makeMusicAlbum(albumImage: self.albumImage ?? myData, artistName: self.artistName ?? "Unknown artist", albumName: self.albumName ?? "Unknown album name")
        
    }
    
    @objc
    func progButtonPressed2() {
        
        //self.albumVM.makeMusicAlbum(albumImage: self.albumImage!, artistName: self.artistName!)
        
        print("Unfavorite Button tapped!!!")
        
        self.progButton2.backgroundColor = UIColorFromRGB(rgbValue: 0x404040)
        self.progButton2.setTitleColor(.white, for: .normal)
        
        //self.albumVM.deleteAlbum2()
        self.albumVM.deleteAlbumByAlbumName(albumName: self.albumName ?? "Un Verano Sin Ti")
        
    }
    
    @objc fileprivate func tapMeAnimatedButtonPressed(sender: UIButton) {
        
        //print("My name is: \(self.text)")
        self.animateView(sender)
        
    }
    
    fileprivate func animateView(_ viewToAnimate: UIView) {
        
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        
    }
    
    /* ############################################################################################################################## */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.spacing = 0
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        
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
        
        vStackView.addArrangedSubview(artistNameLabel)
        vStackView.addArrangedSubview(albumNameLabel)
        vStackView2.addArrangedSubview(progButton)
        vStackView2.addArrangedSubview(progButton2)
        hStackView.addArrangedSubview(self.posterImageView)
        //hStackView.addArrangedSubview(self.artistNameLabel)
        //hStackView.addArrangedSubview(self.progButton)
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(vStackView2)
        
        self.contentView.addSubview(hStackView)
        
        self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true

        hStackView.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 8).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        hStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

        self.posterImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.posterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func configure(albumVM: AlbumViewModelType, index: Int) {
        
        self.artistName = albumVM.artistName(for: index)
                
        self.artistNameLabel.text = albumVM.artistName(for: index)
        
        self.albumName = albumVM.albumName(for: index)
        
        self.albumNameLabel.text = albumVM.albumName(for: index)
        
        albumVM.albumImage(for: index) { imageData in
            guard let imageData = imageData else { return }

            self.albumImage = imageData
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: imageData)
            }
        }
        
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
