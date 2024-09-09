//
//  Utilities.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 01/09/24.
//

import Foundation
import Network

/// A class that monitors network reachability and provides updates on network connection status.
///
/// The `Reachability` class conforms to `ObservableObject` and uses `NWPathMonitor` to observe changes
/// in network connectivity. It provides a published property `isConnected` that reflects the current
/// network status. When the network status changes, the `isConnected` property is updated and the
/// changes are broadcast to any subscribers.
///
/// Key Features:
/// - **`monitor`**: An instance of `NWPathMonitor` used to observe network status changes.
/// - **`queue`**: A serial `DispatchQueue` used for processing network status updates.
/// - **`isConnected`**: A published property that indicates whether the device is currently connected
///   to the network. It updates automatically when network status changes.
///
/// - **Initialization**: Sets up the `NWPathMonitor` and starts monitoring network changes.
/// - **Deinitialization**: Stops monitoring network changes and cancels the `NWPathMonitor`.
///
/// Usage:
/// Instantiate `Reachability` to start monitoring network status. The `isConnected` property can be
/// observed to react to network changes in the user interface or other parts of the application.
final class Reachability: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityMonitor")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
