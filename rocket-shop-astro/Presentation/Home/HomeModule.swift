//
//  HomeModule.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

// MARK: Imports

import SwiftyVIPER
import UIKit

// MARK: -

/// Used to initialize the Home VIPER module
final class HomeModule: ModuleProtocol {

	// MARK: - Variables

	private(set) lazy var interactor: HomeInteractor = {
		HomeInteractor()
	}()

	private(set) lazy var router: HomeRouter = {
		HomeRouter()
	}()

	private(set) lazy var presenter: HomePresenter = {
		HomePresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: HomeViewController = {
		HomeViewController(presenter: self.presenter)
	}()

	// MARK: - Module Protocol Variables

	var viewController: UIViewController {
		return view
	}

	// MARK: Inits

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}
