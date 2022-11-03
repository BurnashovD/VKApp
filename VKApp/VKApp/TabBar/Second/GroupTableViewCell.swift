// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой
final class GroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func refresh(_ model: Group) {
        groupImageView.image = UIImage(named: model.groupImageName)
        groupNameLabel.text = model.name
    }

    // MARK: - Private methods

    private func configCell() {
        groupImageView.clipsToBounds = true
        groupImageView.layer.cornerRadius = groupImageView.frame.size.width / 2
    }
}
