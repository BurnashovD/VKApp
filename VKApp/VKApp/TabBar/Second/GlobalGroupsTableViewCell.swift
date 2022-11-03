// GlobalGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с глобальной группой
final class GlobalGroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

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
