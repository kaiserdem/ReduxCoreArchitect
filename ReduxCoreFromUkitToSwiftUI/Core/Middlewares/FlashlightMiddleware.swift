//
//  FlashlightMiddleware.swift
//  ReduxCoreFromUkitToSwiftUI
//
//  Created by Yaroslav Golinskiy on 21/08/2025.
//

import Foundation
import ReduxCore
import AVFoundation

// Actions moved to Core/Actions/Actions.swift to avoid duplication

struct FlashlightMiddleware {
    func middleware() -> Middleware<State> {
        { dispatch, action, _, state in
            switch action {
            case is Actions.MainViewPresenter.Click:
                let shouldOn = !state.torchSettings.isEnabled
                do {
                    try self.toggleTorch(isOn: shouldOn)
                    dispatch(Actions.FlashlightMiddleware.Changed(isEnabled: shouldOn))
                } catch {
                    dispatch(Actions.FlashlightMiddleware.Failed(error: error))
                }
                
            default:
                break
            }
        }
    }
}

// MARK: - Private methods

private extension FlashlightMiddleware {
    func toggleTorch(isOn: Bool) throws {
        guard isSimulator == false else {
            // Simulate success toggling without errors
            return
        }
        
        guard
            let device = AVCaptureDevice.default(for: .video),
            device.hasTorch
        else {
            print("Torch is not available")
            throw NSError(domain: "torch.not_available", code: -33, userInfo: nil)
        }
        
        try device.lockForConfiguration()
        device.torchMode = isOn ? .on : .off
        if isOn {
            try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
        }
        device.unlockForConfiguration()
    }
    
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
}
