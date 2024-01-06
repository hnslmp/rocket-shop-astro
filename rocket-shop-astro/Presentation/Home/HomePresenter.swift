//
//  HomePresenter.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

// MARK: Imports

import UIKit
import RxSwift
import RxCocoa
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `HomePresenter` and referenced by `HomeViewController`
protocol HomeViewPresenterProtocol: ViewPresenterProtocol {
    func getObsProducts() -> BehaviorRelay<[ProductModel]>
    func getObsIsLoadingProducts() -> BehaviorRelay<Bool>
    func goToProductDetail(_ selectedProduct : ProductModel)
    func getObsSearchFilter() -> BehaviorRelay<String>
    func getObsIsError() -> BehaviorRelay<Bool>
    func requestProducts()
}

/// Should be conformed to by the `HomePresenter` and referenced by `HomeInteractor`
protocol HomeInteractorPresenterProtocol: AnyObject {
    func performUpdates()
}

// MARK: -

/// The Presenter for the Home module
final class HomePresenter: HomeViewPresenterProtocol, HomeInteractorPresenterProtocol {


    // MARK: - Constants

    let router: HomePresenterRouterProtocol
    let interactor: HomePresenterInteractorProtocol

    // MARK: Variables

    weak var view: HomePresenterViewProtocol?

    // MARK: Inits

    init(router: HomePresenterRouterProtocol, interactor: HomePresenterInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }

    // MARK: - Home View to Presenter Protocol

    func viewLoaded() {
        
    }
    
    func getObsIsError() -> BehaviorRelay<Bool> {
        interactor.getObsIsError()
    }
    
    func requestProducts() {
        interactor.requestProducts()
    }
    
    func getObsProducts() -> BehaviorRelay<[ProductModel]> {
        interactor.getObsProducts()
    }
    
    func getObsIsLoadingProducts() -> BehaviorRelay<Bool> {
        interactor.getObsIsLoadingProducts()
    }
    
    func getObsSearchFilter() -> BehaviorRelay<String> {
        interactor.getObsSearchFilter()
    }

    // MARK: - Home Interactor to Presenter Protocol
    func performUpdates() {
        view?.performUpdates()
    }
    
    func goToProductDetail(_ selectedProduct : ProductModel) {
        router.goToProductDetail(selectedProduct)
    }
    
    
}
