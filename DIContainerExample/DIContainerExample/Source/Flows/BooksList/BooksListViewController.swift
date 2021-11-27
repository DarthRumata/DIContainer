//
//  BooksListViewController.swift
//  Test1
//
//  Created by Stas Kirichok on 16.11.2021.
//

import UIKit
import Combine

class BooksListViewController: UIViewController {
    var viewModel: BooksListViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var models = [Book]()
    private var cancellableBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        // Reactive
        _ = viewModel.onViewDidLoad.receive(())
        viewModel.books
            .sink { [weak self] books in
                self?.models = books
                self?.tableView.reloadData()
            }
            .store(in: &cancellableBag)
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.register(UINib.init(nibName: BookListCell.id, bundle: nil), forCellReuseIdentifier: BookListCell.id)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension BooksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListCell.id, for: indexPath) as? BookListCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
}
