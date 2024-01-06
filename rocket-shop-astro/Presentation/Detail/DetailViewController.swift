//
//  DetailViewController.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 06/01/24.
//

// MARK: Imports

import UIKit
import RxSwift
import RxCocoa
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `DetailViewController` and referenced by `DetailPresenter`
protocol DetailPresenterViewProtocol: AnyObject {
    func performUpdates()
}

// MARK: -

/// The View Controller for the Detail module
class DetailViewController: UIViewController, DetailPresenterViewProtocol {
    
    // MARK: - Constants
    
    let presenter: DetailViewPresenterProtocol
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .textColor
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .textColor
        return label
    }()

	// MARK: Variables
    var obsProduct: BehaviorRelay<ProductModel?>?
	// MARK: Inits

	init(presenter: DetailViewPresenterProtocol) {
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
        
        obsProduct = presenter.getObsProduct()

        setupView()
		view.backgroundColor = .backgroundColor
    }
    
    func setupView() {

        view.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(view.frame.height / 2)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(4)
            make.trailing.leading.equalToSuperview().offset(8)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.leading.equalToSuperview().offset(8)
        }
        
        performUpdates()
    }
    
    private func setupProductImage(_ product: ProductModel) {
        productImageView.startSkeleton()
        productImageView.sd_setImage(with: URL(string: product.image), completed: { (image, error, cacheType, imageURL) in
            self.productImageView.stopSkeleton()
        })
    }
    
	// MARK: - Detail Presenter to View Protocol

    func performUpdates() {
        
        guard let product = obsProduct?.value else { return }
        
        titleLabel.text = product.title
        priceLabel.text = String(product.price)
        setupProductImage(product)

    }
}
