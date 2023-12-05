//
//  SdkManager.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation

//
// class SdkManager {
//    // Define properties and methods related to SdkManager
//    private var sdkState: SdkState = .notConfigured
//    private let configurableKoinComponent: ConfigurableKoinComponent
//
//    init(configurableKoinComponent: ConfigurableKoinComponent = DefaultKoinComponent()) {
//        self.configurableKoinComponent = configurableKoinComponent
//    }
//
//    var sdkInstance: CfRecyclerInterface {
//        switch sdkState {
//        case .notConfigured, .shutdown:
//            return NoOpSdk()
//        case .ready(let sdk):
//            return sdk
//        }
//    }
//
//    func initialize(application: Application, block: (ClientConfig.Builder) -> Void) {
//        configure(application: application, block: block)
//    }
//
//    func initialize(application: Application, config: ClientConfig) {
//        configure(application: application, config: config)
//    }
//
//    func configure(application: Application, block: (ClientConfig.Builder) -> Void) {
//        configure(application: application, config: ClientConfig.Builder().apply(block).build())
//    }
//
//    func configure(application: Application, config: ClientConfig) {
//        runConfiguration(application: application, baselineConfig: config)
//    }
//
//    func shutdown() {
//        if case .ready = sdkState {
//            runShutdown()
//        }
//    }
//
//    private func runConfiguration(application: Application, baselineConfig: ClientConfig) {
//        if case .ready(let currentState) = sdkState {
//            currentState.shutdown()
//        }
//
//        configurableKoinComponent.configure(application, baselineConfig)
//
//        let newPromotedAi = configurableKoinComponent.get()
//        sdkState = .ready(sdk: newPromotedAi)
//    }
//
//    private func runShutdown() {
//        sdkInstance.shutdown()
//        configurableKoinComponent.shutdown()
//        sdkState = .shutdown
//    }
// }
//
//// Define an enum for SdkState
// enum SdkState {
//    case notConfigured
//    case ready(sdk: CfRecyclerInterface)
//    case shutdown
// }
//
//// Create a protocol for Application
// protocol Application {
//    // Define properties and methods related to Application
// }
//
//// Create a protocol for CfRecyclerInterface
// protocol CfRecyclerInterface {
//    // Define properties and methods related to CfRecyclerInterface
// }
//
//// Create a class for NoOpSdk
// class NoOpSdk: CfRecyclerInterface {
//    // Implement properties and methods related to NoOpSdk
// }
