//
//  omechuApp.swift
//  omechu
//
//  Created by 이창현 on 2023/09/17.
//

import SwiftUI

struct AppData: Identifiable {
    let id = UUID()
    var roomUuid: String = ""
}

class AppDataStore: ObservableObject {
    @Published var appData = AppData()
}

@main
struct omechuApp: App {
    @StateObject var dataStore = AppDataStore()

    var body: some Scene {
        WindowGroup {
            StartAppView()
                .environmentObject(dataStore)
        }
    }
}
