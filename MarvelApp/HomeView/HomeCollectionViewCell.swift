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
    
    func configure() {
        
    
        
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
    }
}
