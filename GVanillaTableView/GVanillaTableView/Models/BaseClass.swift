//
//  BaseClass.swift
//
//  Created by Glenn Posadas on 3/28/17
//  Copyright (c) Citus Lab PH. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class BaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let page = "page"
    static let data = "data"
    static let searchId = "search_id"
    static let perPage = "per_page"
    static let totalCount = "total_count"
    static let spellcheckInfo = "spellcheck_info"
  }

  // MARK: Properties
  public var page: Int?
  public var data: [Data]?
  public var searchId: String?
  public var perPage: Int?
  public var totalCount: Int?
  public var spellcheckInfo: SpellcheckInfo?

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
    page = json[SerializationKeys.page].int
    if let items = json[SerializationKeys.data].array { data = items.map { Data(json: $0) } }
    searchId = json[SerializationKeys.searchId].string
    perPage = json[SerializationKeys.perPage].int
    totalCount = json[SerializationKeys.totalCount].int
    spellcheckInfo = SpellcheckInfo(json: json[SerializationKeys.spellcheckInfo])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = page { dictionary[SerializationKeys.page] = value }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = searchId { dictionary[SerializationKeys.searchId] = value }
    if let value = perPage { dictionary[SerializationKeys.perPage] = value }
    if let value = totalCount { dictionary[SerializationKeys.totalCount] = value }
    if let value = spellcheckInfo { dictionary[SerializationKeys.spellcheckInfo] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? Int
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [Data]
    self.searchId = aDecoder.decodeObject(forKey: SerializationKeys.searchId) as? String
    self.perPage = aDecoder.decodeObject(forKey: SerializationKeys.perPage) as? Int
    self.totalCount = aDecoder.decodeObject(forKey: SerializationKeys.totalCount) as? Int
    self.spellcheckInfo = aDecoder.decodeObject(forKey: SerializationKeys.spellcheckInfo) as? SpellcheckInfo
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(page, forKey: SerializationKeys.page)
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(searchId, forKey: SerializationKeys.searchId)
    aCoder.encode(perPage, forKey: SerializationKeys.perPage)
    aCoder.encode(totalCount, forKey: SerializationKeys.totalCount)
    aCoder.encode(spellcheckInfo, forKey: SerializationKeys.spellcheckInfo)
  }

}
