//
//  DetailRouter.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 06/01/24.
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `DetailRouter` and referenced by `DetailPresenter`
protocol DetailPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the Detail module
final class DetailRouter: RouterProtocol, DetailPresenterRouterProtocol {

	// MARK: - Variables

	weak var viewController: UIViewController?
}
