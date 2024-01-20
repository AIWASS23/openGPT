//
//  ChatViewModel.swift
//  OpenGPT
//
//  Created by Marcelo de Araújo on 12/01/2023.
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject {

    enum State: String {
        case checkingConnection
        case ready
        case disconnected
    }

    private let reachability: Reachability? = try? Reachability()
    private var reachabilityCancellable: AnyCancellable?

    @Published public private(set) var state: State = .checkingConnection


    @Published public var shouldReload: Bool = false

    init() {
        try? reachability?.startNotifier()

        reachabilityCancellable = NotificationCenter.default
            .publisher(for: .reachabilityChanged)
            .compactMap { $0.object as? Reachability }
            .sink { [weak self] in
                guard let self else { return }

                self.state = $0.isConnected ? .ready : .disconnected
            }
    }

    deinit {
        reachability?.stopNotifier()
    }
}

private extension Reachability {
    var isConnected: Bool {
        connection == .wifi || connection == .cellular
    }
}
