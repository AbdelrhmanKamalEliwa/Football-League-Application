//
//  Navigator.swift
//  Football League Application
//
//  Created by Abdelrhman Eliwa on 23/11/2020.
//

import UIKit

enum NavigatorTypes {
    case push
    case present
    case root
}

protocol NavigatorProtocol {
    static func navigate(form view: UIViewController, to destination: Destination, with navigationType: NavigatorTypes)
}

extension NavigatorProtocol {
    static func navigate(form view: UIViewController, to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = Navigator.viewController(for: destination)
        switch navigationType {
        case .push:
            view.navigationController?.pushViewController(viewController, animated: true)
        case .present:
            view.navigationController?.present(viewController, animated: true, completion: nil)
        case .root:
            view.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
}
