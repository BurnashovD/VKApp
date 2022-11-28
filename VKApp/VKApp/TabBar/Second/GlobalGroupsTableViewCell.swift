// GlobalGroupsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Ячейка с глобальной группой
final class GlobalGroupsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupNameLabel: UILabel!

    // MARK: - Private properties

    private lazy var tapImageGestureRecognizer = UITapGestureRecognizer()

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configCell()
    }

    func configure(_ group: Groups, networkService: NetworkService) {
        groupNameLabel.text = group.name
        groupImageView.fetchUserPhotos(group.photo, networkService: networkService)
    }

    // MARK: - Private methods

    private func configCell() {
        groupImageView.clipsToBounds = true
        groupImageView.layer.cornerRadius = groupImageView.frame.size.width / 2
        groupImageView.isUserInteractionEnabled = true
        tapImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateProfileImageAction))
        groupImageView.addGestureRecognizer(tapImageGestureRecognizer)
    }

    @objc private func animateProfileImageAction() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3) {
            self.groupImageView.bounds = CGRect(
                x: self.groupImageView.center.x,
                y: self.groupImageView.center.y,
                width: 81,
                height: 81
            )
        }
    }
}
