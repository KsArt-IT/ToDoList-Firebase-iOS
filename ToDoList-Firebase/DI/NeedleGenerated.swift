

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

private func parent2(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class DataRepositoryDependency943f09251b792f9033e6Provider: DataRepositoryDependency {
    var dataRepository: DataRepository {
        return rootComponent.dataRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->DataComponent->MainComponent
private func factory6568e02e484b6542eaf4a9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return DataRepositoryDependency943f09251b792f9033e6Provider(rootComponent: parent2(component) as! RootComponent)
}
private class DataRepositoryDependency9bdaf2614a68e3db4320Provider: DataRepositoryDependency {
    var dataRepository: DataRepository {
        return rootComponent.dataRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->DataComponent
private func factory1fc63d1bfc36477eea87b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return DataRepositoryDependency9bdaf2614a68e3db4320Provider(rootComponent: parent1(component) as! RootComponent)
}
private class DataRepositoryDependency9854ec5e6fde7eac9ca5Provider: DataRepositoryDependency {
    var dataRepository: DataRepository {
        return rootComponent.dataRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->DataComponent->CreateComponent
private func factory488dd2dff6881fbbf99ea9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return DataRepositoryDependency9854ec5e6fde7eac9ca5Provider(rootComponent: parent2(component) as! RootComponent)
}
private class AuthRepositoryDependency1594dde0ee60075d9239Provider: AuthRepositoryDependency {
    var authRepository: AuthRepository {
        return rootComponent.authRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AuthComponent->ResetPasswordComponent
private func factory0f0f1b586da94dec4538a9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthRepositoryDependency1594dde0ee60075d9239Provider(rootComponent: parent2(component) as! RootComponent)
}
private class AuthRepositoryDependency72382e2b19321dcd0a99Provider: AuthRepositoryDependency {
    var authRepository: AuthRepository {
        return rootComponent.authRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AuthComponent
private func factorya67059ab098a80879279b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthRepositoryDependency72382e2b19321dcd0a99Provider(rootComponent: parent1(component) as! RootComponent)
}
private class AuthRepositoryDependency17cee66a7bad03dd6d8bProvider: AuthRepositoryDependency {
    var authRepository: AuthRepository {
        return rootComponent.authRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AuthComponent->RegistrationComponent
private func factoryf1bac6a637b24a1b79a8a9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthRepositoryDependency17cee66a7bad03dd6d8bProvider(rootComponent: parent2(component) as! RootComponent)
}
private class AuthRepositoryDependency0e4c9eb764dd3d67a367Provider: AuthRepositoryDependency {
    var authRepository: AuthRepository {
        return rootComponent.authRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AuthComponent->LoginComponent
private func factoryfa15f1509b6592543175a9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthRepositoryDependency0e4c9eb764dd3d67a367Provider(rootComponent: parent2(component) as! RootComponent)
}

#else
extension MainComponent: Registration {
    public func registerItems() {
        keyPathToName[\DataRepositoryDependency.dataRepository] = "dataRepository-DataRepository"
    }
}
extension DataComponent: Registration {
    public func registerItems() {
        keyPathToName[\DataRepositoryDependency.dataRepository] = "dataRepository-DataRepository"

    }
}
extension CreateComponent: Registration {
    public func registerItems() {
        keyPathToName[\DataRepositoryDependency.dataRepository] = "dataRepository-DataRepository"
    }
}
extension ResetPasswordComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthRepositoryDependency.authRepository] = "authRepository-AuthRepository"
    }
}
extension AuthComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthRepositoryDependency.authRepository] = "authRepository-AuthRepository"

    }
}
extension RegistrationComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthRepositoryDependency.authRepository] = "authRepository-AuthRepository"
    }
}
extension LoginComponent: Registration {
    public func registerItems() {
        keyPathToName[\AuthRepositoryDependency.authRepository] = "authRepository-AuthRepository"
    }
}
extension RootComponent: Registration {
    public func registerItems() {

        localTable["authRepository-AuthRepository"] = { [unowned self] in self.authRepository as Any }
        localTable["dataRepository-DataRepository"] = { [unowned self] in self.dataRepository as Any }
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
    registerProviderFactory("^->RootComponent->DataComponent->MainComponent", factory6568e02e484b6542eaf4a9403e3301bb54f80df0)
    registerProviderFactory("^->RootComponent->DataComponent", factory1fc63d1bfc36477eea87b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->DataComponent->CreateComponent", factory488dd2dff6881fbbf99ea9403e3301bb54f80df0)
    registerProviderFactory("^->RootComponent->AuthComponent->ResetPasswordComponent", factory0f0f1b586da94dec4538a9403e3301bb54f80df0)
    registerProviderFactory("^->RootComponent->AuthComponent", factorya67059ab098a80879279b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->AuthComponent->RegistrationComponent", factoryf1bac6a637b24a1b79a8a9403e3301bb54f80df0)
    registerProviderFactory("^->RootComponent->AuthComponent->LoginComponent", factoryfa15f1509b6592543175a9403e3301bb54f80df0)
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
