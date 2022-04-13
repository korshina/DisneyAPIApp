//
//  CharacterTableViewCell.swift
//  DisneyAPIApp
//
//  Created by Anastasiia Korshina on 13.04.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            
            characterImageView.layer.cornerRadius = characterImageView.bounds.height / 2
        }
    }
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func configureCell(with character: DisneyCharacter) {
        characterNameLabel.text = character.name
        NetworkManager.shared.fetchImageData(string: character.imageUrl) { result in
            switch result {
            case .success(let data):
                self.characterImageView.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }

}
