import Foundation

public protocol SingletonRetrievable { }

public extension SingletonRetrievable where Self: ResourceObject {
    public typealias SingletonRetrieveOperation = DefaultOperation<Self>
    
    public static func retrieve(using given: Client? = nil, parent: ResourceObject? = nil, callback: Request<SingletonRetrieveOperation>.Callback?) -> Request<SingletonRetrieveOperation>? {
        guard checkParent(self, parent: parent) else {
            return nil
        }
        
        let operation = SingletonRetrieveOperation(
            endpoint: info.endpoint,
            method: "GET",
            paths: buildResourcePaths(self, parent: parent)
        )
        
        let client = resolveClient(given: given)
        return client.call(operation, callback: callback)
    }
}