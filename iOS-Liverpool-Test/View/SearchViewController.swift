//
//  SearchViewController.swift
//  iOS-Project
//
//  Created by Ana Bernal on 30/08/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var loadingView: UIVisualEffectView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Task { await fetchData() }
    }
    
    func configureUI() {
        productTableView.delegate = self
        productTableView.dataSource = self
        searchBar.delegate = self
        showLoadingView()
    }
    
    func fetchData(searchTerm: String = "") async {
        await viewModel.fetchProducts(searchTerm: searchTerm)
        productTableView.reloadData()
        hideLoadingView()
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
        spinnerView.startAnimating()
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
        spinnerView.stopAnimating()
    }
    
    func createTableFooterSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: productTableView.frame.width, height: 50))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = UIColor.accent
        spinner.center = footerView.center
        spinner.startAnimating()
        footerView.addSubview(spinner)
        return footerView
    }

    func showTableFooterSpinner() {
        productTableView.tableFooterView = createTableFooterSpinner()
    }
    
    func hideTableFooterSpinner() {
        productTableView.tableFooterView = nil
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.products.count - 1 {
            showTableFooterSpinner()
            Task {
                await viewModel.loadMore()
                hideTableFooterSpinner()
                tableView.reloadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Task { await fetchData(searchTerm: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
