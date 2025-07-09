//
//  ViewController.swift
//  Networking
//
//  Created by Bartosz Strzecha on 07/07/2025.
//

import UIKit

final class TVShowViewController: UIViewController {
    private let viewModel: TVShowViewModel
    private let tableView = UITableView()

    init(viewModel: TVShowViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated Shows"
        view.backgroundColor = .systemBackground
        setupTableView()
        fetchShows()
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.register(ShowCell.self, forCellReuseIdentifier: "ShowCell")
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    private func fetchShows() {
        viewModel.fetchTVShows { [weak self] error in
            if let error = error {
                self?.showAlert(error: error)
            } else {
                self?.tableView.reloadData()
            }
        }
    }

    private func showAlert(error: TMDBError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension TVShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = viewModel.shows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as! ShowCell
        cell.configure(with: show, imageURL: viewModel.imageURL(for: show.posterPath))
        return cell
    }
}

