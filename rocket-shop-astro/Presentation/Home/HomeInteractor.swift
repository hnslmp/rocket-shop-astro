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
    func getObsSearchFilter() -> BehaviorRelay<String>
    func getObsIsError() -> BehaviorRelay<Bool>
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
    private var obsSearchFilter: BehaviorRelay<String> = BehaviorRelay(value: "")
    private var obsProductsResponse: BehaviorRelay<[ProductModel]> = BehaviorRelay(value: [])
    private var obsIsError: BehaviorRelay<Bool> = BehaviorRelay(value: false)
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
        
        obsProductsResponse.subscribe( onNext: {[weak self] response in
            var products = self?.obsProducts.value ?? []
            products.append(contentsOf: response)
            self?.obsProducts.accept(products)
        }).disposed(by: disposeBag)
        
        obsSearchFilter.subscribe(onNext: { [weak self] result in
            let products = self?.obsProductsResponse.value ?? []
            if result.isEmpty {
                self?.obsProducts.accept(products)
            } else {
                self?.obsProducts.accept(products.filter({ $0.title.contains(result)}))
            }
        }).disposed(by: disposeBag)
    }
    
    func getObsProducts() -> BehaviorRelay<[ProductModel]> {
        obsProducts
    }
    
    func getObsIsError() -> BehaviorRelay<Bool> {
        obsIsError
    }
    
    func getObsIsLoadingProducts() -> BehaviorRelay<Bool> {
        obsIsLoadingProducts
    }
    
    func getObsSearchFilter() -> BehaviorRelay<String> {
        obsSearchFilter
    }
    
    func requestProducts() {
        obsIsLoadingProducts.accept(true)
        service.requestProducts { result in
            switch result {
            case .success(let result):
                var products = self.obsProducts.value
                products.append(contentsOf: result)
                self.obsProductsResponse.accept(products)
                self.obsIsLoadingProducts.accept(false)
            case .failure(let error):
                self.obsIsError.accept(true)
                self.obsIsLoadingProducts.accept(false)
                print(error.localizedDescription)
                
                // TODO: show error state snackbar
            }
        }
        
    }
}
