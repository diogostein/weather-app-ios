//
//  DailyForecastViewCell.swift
//  Weather App
//
//  Created by Diogo Ishihara Stein on 17/06/24.
//

import UIKit

class DailyForecastViewCell: UITableViewCell, SetupViewContract {
    
    static let identifier: String = "DailyForecastViewCell"
    
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TER"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "min 25°C"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "max 25°C"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIWeatherImage.rainyCloudIcon
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [weekDayLabel, iconImageView, minTempLabel, maxTempLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 15
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8, leading: 35, bottom: 8, trailing: 35
        )
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        stackView.setConstraintsToParent(contentView)
        
        NSLayoutConstraint.activate([
            weekDayLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 77),
            iconImageView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
}
