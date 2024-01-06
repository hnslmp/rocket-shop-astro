//
//  HomeViewController.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

// MARK: Imports

import UIKit
import SnapKit
import SwiftyVIPER
import RxSwift
import RxCocoa

// MARK: Protocols

/// Should be conformed to by the `HomeViewController` and referenced by `HomePresenter`
protocol HomePresenterViewProtocol: AnyObject {
    func performUpdates()
}

// MARK: -

/// The View Controller for the Home module
class HomeViewController: UIViewController, HomePresenterViewProtocol {

    // MARK: - Constants
    let presenter: HomeViewPresenterProtocol
    var obsProducts: BehaviorRelay<[ProductModel]>?
    var obsSearchFilter: BehaviorRelay<String>?
    var obsIsLoadingProducts: BehaviorRelay<Bool>?

    // MARK: Variables
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .white
        return view
    }()
    
    private let searchBar:UISearchBar = {
        let search = UISearchBar()
        let textFieldInsideSearchBar = search.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .textColor
        search.tintColor = .white
        search.barTintColor = .backgroundColor
        return search
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Products"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .textColor
        return label
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    // MARK: Inits
    init(presenter: HomeViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        
        obsProducts = presenter.getObsProducts()
        obsIsLoadingProducts = presenter.getObsIsLoadingProducts()
        obsSearchFilter = presenter.getObsSearchFilter()
        
        presenter.requestProducts()
        
        setupNavbar()
        setupCollectionView()
        setupView()

    }
    
    private func setupNavbar() {
        self.navigationItem.title = "Rocket Shop"
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HomeCollectionViewCell.self))
        collectionView.backgroundColor = .clear

        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8;
        layout.minimumLineSpacing = 8;
        collectionView.collectionViewLayout = layout
        
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundColor
        searchBar.delegate = self
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(24)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }

    // MARK: - Home Presenter to View Protocol
    func performUpdates() {
        if let isLoadingProducts = obsIsLoadingProducts?.value {
            if isLoadingProducts {
                spinner.startAnimating()
            } else {
                spinner.stopAnimating()
            }
        }
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = obsProducts?.value else { return 0 }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCollectionViewCell.self), for: indexPath) as! HomeCollectionViewCell
        
        if let products = obsProducts?.value {
            cell.setupView(product: products[indexPath.row])
        } else {
            cell.setupBroken()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = AppHelper.shared.screenWidth / 2.5
        let cellHeight = cellWidth / 2 * 3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let products = obsProducts?.value else { return }
        let selectedProduct = products[indexPath.row]
        presenter.goToProductDetail(selectedProduct)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        obsSearchFilter?.accept(searchText)
    }
}
