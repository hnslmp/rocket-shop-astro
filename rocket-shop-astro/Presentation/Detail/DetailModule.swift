//
//  DetailModule.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 06/01/24.
//

// MARK: Imports

import SwiftyVIPER
import UIKit
import RxSwift
import RxCocoa

// MARK: -

/// Used to initialize the Detail VIPER module
final class DetailModule: ModuleProtocol {

	// MARK: - Variables

	private(set) lazy var interactor: DetailInteractor = {
		DetailInteractor()
	}()

	private(set) lazy var router: DetailRouter = {
		DetailRouter()
	}()

	private(set) lazy var presenter: DetailPresenter = {
		DetailPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: DetailViewController = {
		DetailViewController(presenter: self.presenter)
	}()

	// MARK: - Module Protocol Variables

	var viewController: UIViewController {
		return view
	}

	// MARK: Inits

    init(product: ProductModel) {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
        interactor.obsProduct.accept(product)
	}
}
