import Foundation

public struct DeletedObject<DeletedObjectType: Destroyable & OmiseResourceObject>: OmiseLiveModeObject, Equatable, Decodable {
    public let isLive: Bool
    public let object: String
    public let id: String
}

extension DeletedObject {
    private enum CodingKeys: String, CodingKey {
        case object
        case id
        case isLive = "livemode"
    }
}

public protocol Destroyable {}

public extension Destroyable where Self: OmiseResourceObject {
    public typealias DestroyEndpoint = APIEndpoint<DeletedObject<Self>>
    public typealias DestroyRequest = APIRequest<DeletedObject<Self>>
    
    public static func destroyEndpointWith(parent: OmiseResourceObject?, id: String) -> DestroyEndpoint {
        return DestroyEndpoint(
            pathComponents: Self.makeResourcePathsWithParent(parent, id: id),
            parameter: .delete
        )
    }
    
    public static func destroy(using client: APIClient, parent: OmiseResourceObject? = nil, id: String, callback: @escaping DestroyRequest.Callback) -> DestroyRequest? {
        guard Self.verifyParent(parent) else {
            return nil
        }
        
        let endpoint = self.destroyEndpointWith(parent: parent, id: id)
        return client.requestToEndpoint(endpoint, callback: callback)
    }
}
