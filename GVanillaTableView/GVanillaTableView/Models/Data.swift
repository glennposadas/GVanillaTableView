//
//  Data.swift
//
//  Created by Glenn Posadas on 3/28/17
//  Copyright (c) Citus Lab PH. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Data: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let imageType = "image_type"
    static let contributor = "contributor"
    static let aspect = "aspect"
    static let descriptionValue = "description"
    static let assets = "assets"
    static let mediaType = "media_type"
  }

  // MARK: Properties
  public var id: String?
  public var imageType: String?
  public var contributor: Contributor?
  public var aspect: Float?
  public var descriptionValue: String?
  public var assets: Assets?
  public var mediaType: String?

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
    id = json[SerializationKeys.id].string
    imageType = json[SerializationKeys.imageType].string
    contributor = Contributor(json: json[SerializationKeys.contributor])
    aspect = json[SerializationKeys.aspect].float
    descriptionValue = json[SerializationKeys.descriptionValue].string
    assets = Assets(json: json[SerializationKeys.assets])
    mediaType = json[SerializationKeys.mediaType].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = imageType { dictionary[SerializationKeys.imageType] = value }
    if let value = contributor { dictionary[SerializationKeys.contributor] = value.dictionaryRepresentation() }
    if let value = aspect { dictionary[SerializationKeys.aspect] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = assets { dictionary[SerializationKeys.assets] = value.dictionaryRepresentation() }
    if let value = mediaType { dictionary[SerializationKeys.mediaType] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.imageType = aDecoder.decodeObject(forKey: SerializationKeys.imageType) as? String
    self.contributor = aDecoder.decodeObject(forKey: SerializationKeys.contributor) as? Contributor
    self.aspect = aDecoder.decodeObject(forKey: SerializationKeys.aspect) as? Float
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.assets = aDecoder.decodeObject(forKey: SerializationKeys.assets) as? Assets
    self.mediaType = aDecoder.decodeObject(forKey: SerializationKeys.mediaType) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(imageType, forKey: SerializationKeys.imageType)
    aCoder.encode(contributor, forKey: SerializationKeys.contributor)
    aCoder.encode(aspect, forKey: SerializationKeys.aspect)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(assets, forKey: SerializationKeys.assets)
    aCoder.encode(mediaType, forKey: SerializationKeys.mediaType)
  }

}
