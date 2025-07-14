//
//  ShowCell.swift
//  Networking
//
//  Created by Bartosz Strzecha on 08/07/2025.
//

import UIKit

final class ShowCell: UITableViewCell {
    private let showImageView = UIImageView()
    private let titleLabel = UILabel()
    private let firstAirDateLabel = UILabel()
    private let ratingLabel = UILabel()
    private let countriesLabel = UILabel()
    private let popularityLabel = UILabel()
    private let overviewLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setup() {
        showImageView.contentMode = .scaleAspectFill
        showImageView.clipsToBounds = true
        titleLabel.font = .boldSystemFont(ofSize: 16)
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.numberOfLines = 0
        
        let labelsBelowTitle = [firstAirDateLabel, ratingLabel, countriesLabel, popularityLabel]
        for label in labelsBelowTitle {
            label.font = .systemFont(ofSize: 12)
        }
        
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel] + labelsBelowTitle)
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        
        let horizontalStackView = UIStackView(arrangedSubviews: [showImageView, labelsStackView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.spacing = 12
        

        let container = UIStackView(arrangedSubviews: [horizontalStackView, overviewLabel])
        container.spacing = 12
        container.axis = .vertical
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            showImageView.widthAnchor.constraint(equalToConstant: 100),
            showImageView.heightAnchor.constraint(equalToConstant: 140),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with show: TVShow, imageURL: URL?) {
        titleLabel.text = show.name
        firstAirDateLabel.text = "First air date: \(show.firstAirDate)"
        ratingLabel.text = "Rating: " + String(format: "%.1f", show.rating)
        countriesLabel.text = "Countries: " + show.originCountry.joined(separator: ", ")
        popularityLabel.text = "Popularity: " + String(format: "%.0f", show.popularity)
        overviewLabel.text = show.description
        if let url = imageURL {
            loadImage(from: url)
        } else {
            showImageView.image = UIImage(systemName: "photo")
        }
    }

    private func loadImage(from url: URL) {
        showImageView.image = nil
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.showImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
