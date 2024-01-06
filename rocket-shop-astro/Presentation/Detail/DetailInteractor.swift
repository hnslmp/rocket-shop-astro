//
//  DetailInteractor.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 06/01/24.
//

// MARK: Imports

import Foundation
import SwiftyVIPER
import RxSwift
import RxCocoa

// MARK: Protocols

/// Should be conformed to by the `DetailInteractor` and referenced by `DetailPresenter`
protocol DetailPresenterInteractorProtocol {
    func getObsProduct() -> BehaviorRelay<ProductModel?>
}

// MARK: -

/// The Interactor for the Detail module
final class DetailInteractor: DetailPresenterInteractorProtocol {

	// MARK: - Variables
    var obsProduct: BehaviorRelay<ProductModel?> = BehaviorRelay(value: nil)
	weak var presenter: DetailInteractorPresenterProtocol?
    private let disposeBag = DisposeBag()

	// MARK: - Detail Presenter to Interactor Protocol
    
    init() {
        setupObserver()
    }
    
    func setupObserver() {
        obsProduct.subscribe { [weak self] _ in
            self?.presenter?.performUpdates()
        }.disposed(by: disposeBag)
    }
    
    func getObsProduct() -> BehaviorRelay<ProductModel?> {
        obsProduct
    }
    
}
