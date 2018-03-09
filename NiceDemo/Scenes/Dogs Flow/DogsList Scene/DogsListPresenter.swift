//
//  DogsListPresenter.swift
//  NiceDemo
//
//  Created by Serhii Kharauzov on 3/9/18.
//  Copyright © 2018 Serhii Kharauzov. All rights reserved.
//

import Foundation

protocol DogsListSceneDelegate: class {
    
}

class DogsListPresenter {

    // MARK: Public properties
    
    weak var delegate: DogsListSceneDelegate?
    
    // MARK: Private properties

    private weak var view: DogsListViewInterface!
    
    // MARK: Public methods
    
    init(view: DogsListViewInterface) {
        self.view = view
    }
    
    // MARK: Private methods
}

// MARK: DogsListPresentation Protocol

extension DogsListPresenter: DogsListPresentation {
    func onViewDidLoad() {
        
    }
}
