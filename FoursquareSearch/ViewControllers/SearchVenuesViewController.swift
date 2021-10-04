//
//  SearchVenuesViewController.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import UIKit

final class SearchVenuesViewController: FSDataLoadingVC {
    
    var searchVenuesPresenter: SearchVenuesProtocol!
    private var tableView: UITableView!
    
    init(service: FoursquareServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        searchVenuesPresenter = SearchVenuesPresenter(service: service, viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureTableView()
    }

    // MARK: - Configure UI
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.rowHeight = 50
        tableView.register(VenueCell.self, forCellReuseIdentifier: VenueCell.reuseId)
        
        view.addSubview(tableView)
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationController() {
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true

        let searchController = UISearchController()

        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search your place"
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        navigationItem.title = "Foursquare"

    }
    
    func showingNewSearchs() {
        tableView.reloadData()
        
        if tableView.numberOfRows(inSection: 0) > 0 {
            dismissEmptyStateView()
            tableView.isHidden = false
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
        } else {
            tableView.isHidden = true
            showEmptyStateView(with: "Can't find any place, please try different word", in: view)
        }
    }
}

// MARK: - extension SearchVenuesViewController TableView

extension SearchVenuesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVenuesPresenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VenueCell.reuseId, for: indexPath) as? VenueCell else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: VenueCell.reuseId)
        }
        
        let venue = searchVenuesPresenter.getItem(atPosition: indexPath.row)
        cell.set(venue: venue)
        
        return cell
    }
}

// MARK: - extension SearchVenuesViewController SearchBar and ScrollView

extension SearchVenuesViewController: UISearchBarDelegate, UIScrollViewDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchVenuesPresenter.searchVenues(with: searchText, appRunFirstTime: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // hide search bar when user scroll down
        if (scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) {
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
}

