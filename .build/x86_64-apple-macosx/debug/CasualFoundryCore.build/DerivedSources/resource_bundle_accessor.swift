import class Foundation.Bundle

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("CausalFoundry_ios_SDK_CasualFoundryCore.bundle").path
        let buildPath = "/Users/khushbu/Documents/CausalFoundry_ios_SDK/.build/x86_64-apple-macosx/debug/CausalFoundry_ios_SDK_CasualFoundryCore.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}