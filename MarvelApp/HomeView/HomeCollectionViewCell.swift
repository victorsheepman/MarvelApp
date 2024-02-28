//
//  HomeCollectionViewCell.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelView: UILabel!
    
    private var gradientLayer: CAGradientLayer?
    
    var imageDecode:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureGradientLayer()
        configure()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //AJUSTAR A TODO EL MARCO DE LA CELDA
        gradientLayer?.frame = bounds
    }
    
    private func configureGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer?.frame = bounds
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, above: imageView.layer)
        }
        backgroundColor = .clear
    }
    private func configure() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        
        layer.cornerRadius = 23
        // Modificar el tamaño del UILabel
        labelView.frame.size = CGSize(width: 200, height: 100)
        
        // Modificar la posición del UILabel
        labelView.frame.origin = CGPoint(x: 20, y: 20)
        
        
        labelView.textColor = .white
        labelView.textAlignment = .left
        //labelView.font.
        
        // Permitir múltiples líneas y ajuste de palabras para el UILabel
        
        labelView.lineBreakMode = .byWordWrapping
        labelView.numberOfLines = 0
        
        bringSubviewToFront(labelView)
    }
    

}
