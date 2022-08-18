//
//  EvangelistWeatherAppApp.swift
//  Shared
//
//  Created by Ragul ML on 16/08/22.
//

import SwiftUI

@main
struct EvangelistWeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LandingListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
