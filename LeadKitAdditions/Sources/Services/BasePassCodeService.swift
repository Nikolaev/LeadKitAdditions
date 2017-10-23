//
//  Copyright (c) 2017 Touch Instinct
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the Software), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import KeychainAccess
import CocoaLumberjack
import IDZSwiftCommonCrypto

/// Represents base pass code service which encapsulates pass code storing
open class BasePassCodeService {

    /// Override to set specific keychain service name
    open class var keychainService: String {
        return Bundle.main.bundleIdentifier ?? ""
    }

    public init() {
        let initialLoadValue = UserDefaults.standard.value(forKey: Keys.isInitialLoad)
        if initialLoadValue == nil {
            UserDefaults.standard.set(Values.initialLoad, forKey: Keys.isInitialLoad)
            reset()
        }
    }

    // MARK: - Private stuff

    fileprivate lazy var keychain: Keychain = {
        return Keychain(service: BasePassCodeService.keychainService)
            .synchronizable(false)
    }()

    fileprivate var passCodeHash: String? {
        return keychain[Keys.passCodeHash]
    }

    fileprivate enum Keys {
        static let passCodeHash     = "passCodeHash"
        static let isTouchIdEnabled = "isTouchIdEnabled"
        static let isInitialLoad    = "isInitialLoad"
    }

    fileprivate enum Values {
        static let touchIdEnabled = "touchIdEnabled"
        static let initialLoad = "initialLoad"
    }

}

extension BasePassCodeService {

    /// Indicates is pass code already saved on this device
    public var isPassCodeSaved: Bool {
        return keychain[Keys.passCodeHash] != nil
    }

    /// Indicates is it possible to authenticate on this device via touch id
    public var isTouchIdEnabled: Bool {
        get {
            return keychain[Keys.isTouchIdEnabled] == Values.touchIdEnabled
        }
        set {
            keychain[Keys.isTouchIdEnabled] = newValue ? Values.touchIdEnabled : nil
        }
    }

    /// Saves new pass code
    public func save(passCode: String?) {
        if let passCode = passCode {
            keychain[Keys.passCodeHash] = sha256(passCode)
        } else {
            keychain[Keys.passCodeHash] = nil
        }
    }

    /// Check if pass code is correct
    public func check(passCode: String) -> Bool {
        return sha256(passCode) == passCodeHash
    }

    /// Reset pass code settings
    public func reset() {
        save(passCode: nil)
        isTouchIdEnabled = false
    }

}

private extension BasePassCodeService {

    func sha256(_ str: String) -> String? {
        guard let digests = Digest(algorithm: .sha256).update(string: str)?.final() else {
            return nil
        }
        return hexString(fromArray: digests)
    }

}
