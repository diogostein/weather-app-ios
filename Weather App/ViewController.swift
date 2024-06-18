//
//  ViewController.swift
//  Weather App
//
//  Created by Diogo Ishihara Stein on 13/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIWeatherImage.background
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.text = "São Paulo"
        label.textAlignment = .center
        label.textColor = UIWeatherColor.primaryColor
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.text = "25°C"
        label.textAlignment = .left
        label.textColor = UIWeatherColor.primaryColor
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIWeatherImage.sunIcon
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Umidade"
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "1000mm"
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [humidityLabel, humidityValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "Vento"
        label.textColor = .white
        return label
    }()
    
    private lazy var windValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "10km/h"
        label.textColor = .white
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [windLabel, windValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [humidityStackView, windStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.backgroundColor = UIWeatherColor.softGray
        stack.layer.cornerRadius = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 12, leading: 24, bottom: 12, trailing: 24
        )
        return stack
    }()
    
    private lazy var hourlyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "PREVISÃO POR HORA"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var hourlyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.register(
            HourlyForecastViewCell.self,
            forCellWithReuseIdentifier: HourlyForecastViewCell.identifier
        )
        
        return collection
    }()
    
    private lazy var dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "PRÓXIMOS DIAS"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(
            DailyForecastViewCell.self,
            forCellReuseIdentifier: DailyForecastViewCell.identifier
        )
        tableView.separatorColor = .white
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(statsStackView)
        view.addSubview(hourlyForecastLabel)
        view.addSubview(hourlyForecastCollectionView)
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyForecastTableView)
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 169),
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 21),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 26),
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 21),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -26),
        ])
        
        NSLayoutConstraint.activate([
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 206),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 24),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
        ])
        
        NSLayoutConstraint.activate([
            hourlyForecastCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            hourlyForecastCollectionView.heightAnchor.constraint(equalToConstant: 84),
            hourlyForecastCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hourlyForecastCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyForecastCollectionView.bottomAnchor, constant: 24),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            dailyForecastLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
        ])
        
        NSLayoutConstraint.activate([
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 22),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyForecastViewCell.identifier, 
            for: indexPath
        )
        return cell
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DailyForecastViewCell.identifier,
            for: indexPath
        )
        return cell
    }
}

