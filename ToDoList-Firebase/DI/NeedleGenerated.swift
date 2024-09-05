

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class RepositoryDependency006c7d880fec28863ecaProvider: RepositoryDependency {
    var authRepository: AuthRepository {
        return rootComponent.authRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->LoginComponent
private func factorya688cdcfe16e346b8256b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RepositoryDependency006c7d880fec28863ecaProvider(rootComponent: parent1(component) as! RootComponent)
}

#else
extension LoginComponent: Registration {
    public func registerItems() {
        keyPathToName[\RepositoryDependency.authRepository] = "authRepository-AuthRepository"
    }
}
extension RootComponent: Registration {
    public func registerItems() {

        localTable["authRepository-AuthRepository"] = { [unowned self] in self.authRepository as Any }
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->RootComponent->LoginComponent", factorya688cdcfe16e346b8256b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
