//
//  HomeInteractor.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

// MARK: Imports

import Foundation
import SwiftyVIPER
import RxSwift
import RxCocoa

// MARK: Protocols

/// Should be conformed to by the `HomeInteractor` and referenced by `HomePresenter`
protocol HomePresenterInteractorProtocol {
    func getObsProducts() -> BehaviorRelay<[ProductModel]>
    func getObsIsLoadingProducts() -> BehaviorRelay<Bool>
    func requestProducts()
}

// MARK: -

/// The Interactor for the Home module
final class HomeInteractor: HomePresenterInteractorProtocol {

    // MARK: - Variables

    weak var presenter: HomeInteractorPresenterProtocol?
    
    private let disposeBag = DisposeBag()
    private var obsProducts: BehaviorRelay<[ProductModel]> = BehaviorRelay(value: [])
    private var obsIsLoadingProducts = BehaviorRelay<Bool>(value: false)
    
    private let service = Service.shared

    // MARK: - Home Presenter to Interactor Protocol
    init() {
        setupObserver()
    }
    
    func setupObserver() {
        obsProducts.subscribe { [weak self] _ in
            self?.presenter?.performUpdates()
        }.disposed(by: disposeBag)
        
        obsIsLoadingProducts.subscribe { [weak self] _ in
            self?.presenter?.performUpdates()
        }.disposed(by: disposeBag)
    }
    
    func getObsProducts() -> BehaviorRelay<[ProductModel]> {
        obsProducts
    }
    
    func getObsIsLoadingProducts() -> BehaviorRelay<Bool> {
        obsIsLoadingProducts
    }
    
    func requestProducts() {
        obsIsLoadingProducts.accept(true)
        service.requestProducts { result in
            switch result {
            case .success(let result):
                var products = self.obsProducts.value
                products.append(contentsOf: result)
                self.obsProducts.accept(products)
                self.obsIsLoadingProducts.accept(false)
            case .failure(let error):
                self.obsIsLoadingProducts.accept(false)
                print(error.localizedDescription)
                
                // TODO: show error state snackbar
            }
        }
        
    }
}
