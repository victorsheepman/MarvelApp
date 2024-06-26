//
//  HomeCollectionViewCell.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var labelView: UILabel!
    
    private var gradientLayer: CAGradientLayer?
    

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
            layer.insertSublayer(gradientLayer, at:0)
        }
        backgroundColor = .clear
    }
    private func configure() {
              
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
    
    func setBackgroundImage(image: UIImage?) {
            backgroundView = UIImageView(image: image)
            backgroundView?.contentMode = .scaleAspectFill
            backgroundView?.clipsToBounds = true
    }
    

}
