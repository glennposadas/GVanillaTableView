//
//  Assets.swift
//
//  Created by Glenn Posadas on 3/28/17
//  Copyright (c) Citus Lab PH. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Assets: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let smallThumb = "small_thumb"
    static let preview = "preview"
    static let largeThumb = "large_thumb"
  }

  // MARK: Properties
  public var smallThumb: SmallThumb?
  public var preview: Preview?
  public var largeThumb: LargeThumb?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    smallThumb = SmallThumb(json: json[SerializationKeys.smallThumb])
    preview = Preview(json: json[SerializationKeys.preview])
    largeThumb = LargeThumb(json: json[SerializationKeys.largeThumb])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = smallThumb { dictionary[SerializationKeys.smallThumb] = value.dictionaryRepresentation() }
    if let value = preview { dictionary[SerializationKeys.preview] = value.dictionaryRepresentation() }
    if let value = largeThumb { dictionary[SerializationKeys.largeThumb] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.smallThumb = aDecoder.decodeObject(forKey: SerializationKeys.smallThumb) as? SmallThumb
    self.preview = aDecoder.decodeObject(forKey: SerializationKeys.preview) as? Preview
    self.largeThumb = aDecoder.decodeObject(forKey: SerializationKeys.largeThumb) as? LargeThumb
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(smallThumb, forKey: SerializationKeys.smallThumb)
    aCoder.encode(preview, forKey: SerializationKeys.preview)
    aCoder.encode(largeThumb, forKey: SerializationKeys.largeThumb)
  }

}
