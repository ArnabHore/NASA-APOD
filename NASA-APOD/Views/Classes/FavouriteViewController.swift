//
//  FavouriteViewController.swift
//  NASA-APOD
//
//  Created by Arnab Hore on 13/11/22.
//

import UIKit

class FavouriteViewController: UIViewController {
    @IBOutlet weak var mainTable: UITableView! {
        didSet {
            mainTable.dataSource = self
            mainTable.delegate = self
            mainTable.separatorStyle = .none
            mainTable.allowsMultipleSelectionDuringEditing = false
            mainTable.rowHeight = UITableView.automaticDimension
            mainTable.register(UINib(nibName: cell, bundle: Bundle(for: FavouriteTableViewCell.self)), forCellReuseIdentifier: cell)
        }
    }
    
    let cell = "FavouriteTableViewCell"
    var favouriteList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// UI elements setup
    private func setupUI() {
        self.title = "Favourites"
        self.navigationController?.navigationBar.tintColor = .label
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as? FavouriteTableViewCell else { return UITableViewCell() }
        
        let favourite = self.favouriteList[indexPath.row]
        cell.configure(favourite: favourite)
        return cell
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
