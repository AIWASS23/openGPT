//
//  ChatApp.swift
//  OpenGPT
//
//  Created by Marcelo de Araújo on 12/01/2023.
//

import SwiftUI

@main
struct OpenGPT: App {
    private let configuration: ChatConfiguration = .release

    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            ChatView()
                .environmentObject(configuration)
        }
        #endif

        #if os(macOS)
        MenuBarExtra {
            ChatView()
                .environmentObject(configuration)
                .background(.ultraThinMaterial)
                .frame(
                    width: configuration.defaultWindowSize.width,
                    height: configuration.defaultWindowSize.height
                )
        } label: {
            configuration.menuIcon
        }
        .menuBarExtraStyle(.window)
        #endif
    }
}
