//
//  ViewController.swift
//  MarvellRequest
//
//  Created by Daniil Davidovich on 14.03.23.
//

import UIKit
import Alamofire

class TableViewController: UIViewController {
    
    var comicsModel = [Result]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.indentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        fetchSerias()
    }
    
    //MARK: - SetupView
    
    func setupView() {
        view.backgroundColor = .white
        title = "Marvel"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Setup
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    //MARK: - Layout
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func fetchSerias() {
        
        guard let urlMarvel = NetworkServise().urlMarvel() else { return }

        AF.request(urlMarvel, method: .get).responseDecodable(of: Welcome.self) { responce in
            self.comicsModel = responce.value?.data.results ?? []
            self.tableView.reloadData()
        }
    }
}


extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.indentifier, for: indexPath) as? TableViewCell
        cell?.comicsDidSet = self.comicsModel[indexPath.row]
        return cell ?? TableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = DetailViewController()
        modal.items = comicsModel[indexPath.row]
        present(modal, animated: true)
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
