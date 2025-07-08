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
        overviewLabel.numberOfLines = 3

        let stack = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        stack.axis = .vertical
        stack.spacing = 4

        let container = UIStackView(arrangedSubviews: [showImageView, stack])
        container.spacing = 12
        container.alignment = .top
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        showImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            showImageView.widthAnchor.constraint(equalToConstant: 80),
            showImageView.heightAnchor.constraint(equalToConstant: 120),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with show: TVShow, imageURL: URL?) {
        titleLabel.text = show.name
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
