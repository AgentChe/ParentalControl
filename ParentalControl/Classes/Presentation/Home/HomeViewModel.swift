//
//  HomeViewModel.swift
//  ParentalControl
//
//  Created by Андрей Чернышев on 03.10.2023.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
    
}

// MARK: Public
extension HomeViewModel {
    struct Input {}
    
    struct Output {
        let elements: Driver<[HomeTableElement]>
    }
    
    func configure(input: Input) -> Output {
        Output(
            elements: makeElements()
        )
    }
}

// MARK: Private
private extension HomeViewModel {
    func makeElements() -> Driver<[HomeTableElement]> {
        .deferred {
            .just([
                HomeTableElement.seeMore(.webHistory),
                HomeTableElement.webHistory
            ])
        }
    }
}
