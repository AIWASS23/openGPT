//
//  ChatConfiguration.swift
//  OpenGPT
//
//  Created by Marcelo de Araújo on 12/01/2023.
//

import SwiftUI

public final class ChatConfiguration: ObservableObject {
    public let chatURL: URL
    public var menuIcon: Image

    public init(
        url: URL,
        menuIcon: Image = Image("openai.icon3")
    ) {
        self.chatURL = url
        self.menuIcon = menuIcon
    }

    public var defaultWindowSize: CGSize {
        CGSize(width: 450, height: 600)
    }

    public var githubURL: URL {
        URL(string: "https://github.com/AIWASS23")!
    }
}

public extension ChatConfiguration {
    static let release = ChatConfiguration(
        url: URL(string: "https://chat.openai.com/chat/")!
    )

    static let debug = ChatConfiguration(
        url: URL(string: "https://www.google.com")!
    )
}
