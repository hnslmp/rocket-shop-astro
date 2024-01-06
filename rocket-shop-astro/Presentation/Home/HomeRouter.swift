//
//  HomeRouter.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `HomeRouter` and referenced by `HomePresenter`
protocol HomePresenterRouterProtocol: PresenterRouterProtocol {
    func goToProductDetail(_ selectedProduct: ProductModel)
}

// MARK: -

/// The Router for the Home module
final class HomeRouter: RouterProtocol, HomePresenterRouterProtocol {

	// MARK: - Variables

	weak var viewController: UIViewController?
    
    func goToProductDetail(_ selectedProduct : ProductModel) {
        viewController?.navigationController?.pushViewController(DetailModule(product: selectedProduct).view, animated: true)
    }
}
