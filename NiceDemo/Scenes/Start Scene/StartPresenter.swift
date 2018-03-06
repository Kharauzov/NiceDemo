//
//  StartPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/5/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol StartPresenterDelegate: class {
    func userNeedsToAuthenticate()
    func userIsAuthenticated()
}

class StartPresenter {

    // MARK: Public properties
    
    weak var delegate: StartPresenterDelegate?
    
    // MARK: Private properties

    private weak var view: StartViewInterface!
    private let userCredentialsStorage = UserCredentialsStorageService(storage: UserDefaultsLayer())
    
    // MARK: Public methods
    
    init(view: StartViewInterface) {
        self.view = view
    }
    
    // MARK: Private methods
    
    private func checkUserState() {
        // could be some url request here
        // immitation via 'asyncAfter'.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) { [unowned self] in
            // handle of result
            self.view.hideLoading()
            if self.userCredentialsStorage.isUserAuthenticated { // user is authenticated
                self.delegate?.userIsAuthenticated()
            } else { // user needs to authenticate
                self.delegate?.userNeedsToAuthenticate()
            }
        }
    }
}

// MARK: StartPresentation Protocol

extension StartPresenter: StartPresentation {
    func onViewDidLoad() {
        view.showLoading()
        checkUserState()
    }
}
