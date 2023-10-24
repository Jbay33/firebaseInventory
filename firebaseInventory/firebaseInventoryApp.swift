//
//  firebaseInventoryApp.swift
//  firebaseInventory
//
//  Created by  on 10/11/23.
//
import SwiftUI
import FirebaseCore
import FirebaseFirestore


class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}


@main
struct firebaseInventoryApp: App {
    @StateObject var vm = inventoryViewModel()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
