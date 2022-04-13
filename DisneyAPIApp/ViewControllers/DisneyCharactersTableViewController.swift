//
//  DisneyCharactersTableViewController.swift
//  DisneyAPIApp
//
//  Created by Anastasiia Korshina on 13.04.2022.
//

import UIKit

class DisneyCharactersTableViewController: UITableViewController {
    
    var disneyData: DisneyCharactersData?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        getDisneyData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let disneyData = disneyData else { return 0 }
        return disneyData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        
        guard let disneyData = disneyData else {
            return cell
        }
        let character = disneyData.data[indexPath.row]
        cell.configureCell(with: character)
        return cell
    }

// MARK: Private methods
    
    private func getDisneyData() {
        NetworkManager.shared.fetchDisneyData { result in
            switch result {
                case .success(let data):
                self.disneyData = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
// MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        guard let disneyData = disneyData else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = disneyData.data[indexPath.row]
        detailsVC.character = character
    }

}
