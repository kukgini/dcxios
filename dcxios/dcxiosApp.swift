import os
import SwiftUI

@main
struct dcxiosApp: App {
    private let logger: Logger
    
    init() {
        //앱 실행 전 초기화 작업 or 필요한 네트워킹
        //앱이 실행되기도 전에 실행해야 하는 작업들은 여기에 구현
        self.logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: type(of: self))
        )
    }
    
    @StateObject private var appStates = ApplicationStates.singleton
    @State var authorized = false
    @State var error: LocalizedError?
    @State var showError: Bool = false
    
    var body: some Scene {
        WindowGroup {
                ContentView().environmentObject(appStates)
        }
    }
}
