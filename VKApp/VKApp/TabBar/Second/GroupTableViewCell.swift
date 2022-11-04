// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с группой
final class GroupTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(_ group: Group) {
        groupImageView.image = UIImage(named: group.groupImageName)
        groupNameLabel.text = group.name
    }

    // MARK: - Private methods

    private func configCell() {
        groupImageView.clipsToBounds = true
        groupImageView.layer.cornerRadius = groupImageView.frame.size.width / 2
    }
}
