//
//  DetailPresenter.swift
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

/// Should be conformed to by the `DetailPresenter` and referenced by `DetailViewController`
protocol DetailViewPresenterProtocol: ViewPresenterProtocol {
    func getObsProduct() -> BehaviorRelay<ProductModel?>
}

/// Should be conformed to by the `DetailPresenter` and referenced by `DetailInteractor`
protocol DetailInteractorPresenterProtocol: AnyObject {
    func performUpdates()
}

// MARK: -

/// The Presenter for the Detail module
final class DetailPresenter: DetailViewPresenterProtocol, DetailInteractorPresenterProtocol {

	// MARK: - Constants

	let router: DetailPresenterRouterProtocol
	let interactor: DetailPresenterInteractorProtocol

	// MARK: Variables

	weak var view: DetailPresenterViewProtocol?

	// MARK: Inits

	init(router: DetailPresenterRouterProtocol, interactor: DetailPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}

	// MARK: - Detail View to Presenter Protocol

	func viewLoaded() {
		
	}
    
    func getObsProduct() -> BehaviorRelay<ProductModel?> {
        interactor.getObsProduct()
    }

	// MARK: - Detail Interactor to Presenter Protocol

    func performUpdates() {
        view?.performUpdates()
    }
    
    
}
