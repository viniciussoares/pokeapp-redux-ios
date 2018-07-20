//
//  https://github.com/freshOS/Router
//
//  Created by Sacha Durand Saint Omer on 27/02/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

public protocol Navigation { }

protocol AppNavigationType {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController)
}

protocol RouterType {
    func setupAppNavigation(appNavigation: AppNavigationType)
    func navigate(_ navigation: Navigation, from: UIViewController)
    func didNavigate(block: @escaping (Navigation) -> Void)
    var appNavigation: AppNavigationType? { get }
}

class DefaultRouter: RouterType {
    var appNavigation: AppNavigationType?
    var didNavigateBlocks = [((Navigation) -> Void)] ()

    func setupAppNavigation(appNavigation: AppNavigationType) {
        self.appNavigation = appNavigation
    }

    func navigate(_ navigation: Navigation, from: UIViewController) {
        if let toVC = appNavigation?.viewcontrollerForNavigation(navigation: navigation) {
            appNavigation?.navigate(navigation, from: from, to: toVC)

            for block in didNavigateBlocks {
                block(navigation)
            }
        }
    }

    func didNavigate(block: @escaping (Navigation) -> Void) {
        didNavigateBlocks.append(block)
    }
}
