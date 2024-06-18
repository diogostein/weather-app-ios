//
//  HourlyForecastViewCell.swift
//  Weather App
//
//  Created by Diogo Ishihara Stein on 17/06/24.
//

import UIKit

class HourlyForecastViewCell: UICollectionViewCell, SetupViewContract {
    
    static let identifier: String = "HourlyForecastViewCell"
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "13:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "25°C"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIWeatherImage.sunIcon
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hourLabel, iconImageView, temperatureLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8, leading: 8, bottom: 8, trailing: 8
        )
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.white.cgColor
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        stackView.setConstraintsToParent(contentView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
}
