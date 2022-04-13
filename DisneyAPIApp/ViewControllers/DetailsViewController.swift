//
//  DetailsViewController.swift
//  DisneyAPIApp
//
//  Created by Anastasiia Korshina on 13.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    
    var character: DisneyCharacter!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = character.name
        setUI()
        
    }
    
    private func setUI() {
        characterLabel.text = character.description
        NetworkManager.shared.fetchImageData(string: character.imageUrl) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.characterImageView.image = UIImage(data: data)
            }
        }
    }

}
