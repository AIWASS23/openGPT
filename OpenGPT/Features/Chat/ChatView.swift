//
//  ChatView.swift
//  OpenGPT
//
//  Created by Marcelo de Araújo on 12/01/2023.
//

import SwiftUI
import WebKit
import Combine

public struct ChatView: View {
    @Environment(\.openURL)
    private var openURL

    @EnvironmentObject
    private var configuration: ChatConfiguration

    @StateObject
    private var viewModel = ChatViewModel()

    public var body: some View {
        switch viewModel.state {
        case .checkingConnection:
            ProgressView()
                .progressViewStyle(.circular)
                .accessibilityLabel("Reload")
        case .disconnected:
            Label("Error.NoInternet.Message", systemImage: "network")
                .font(.headline)
                .accessibilityLabel("Not connected to network")
        case .ready:
            chatWebView()
                .accessibilityLabel("ChatGPT")
        }
    }
}

private extension ChatView {
    @ViewBuilder
    func chatWebView() -> some View {
        #if os(macOS)

        VStack(spacing: .zero) {
            ChatToolbar(
                chatURL: configuration.chatURL,
                githubURL: configuration.githubURL,
                reloadAction: { viewModel.shouldReload = true }
            )

            WebView(url: configuration.chatURL, reload: $viewModel.shouldReload)
                .ignoresSafeArea()
                .frame(maxHeight: .infinity, alignment: .center)
        }
        #else
        WebView(url: configuration.chatURL)
            .ignoresSafeArea()
        #endif
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//            .environmentObject(ChatConfiguration.debug)
//    }
//}
