import Foundation
import SwiftyJSON

public protocol JSONSerializable{
  func toDict() -> [String:Any]
}

public protocol JSONDeserializable{
  init(json:JSON)
}

extension JSONDeserializable{
  public static func objectsFrom(json: JSON) -> [Self]{
    return json.map{ Self(json:$0.1) }
  }

  public static func objectsFrom(dict json:JSON, fieldName:String = "index") -> [Self]{
    var objects: [Self] = []
    for  (key,subJson):(String,JSON) in json{
      var dict = subJson.dictionaryObject!
      dict[fieldName] = key
      let object = Self(json: JSON(dict))
      objects.append(object)
    }
    return objects
  }

  public static func objectsMapFrom(dict json:JSON) -> [String:Self]{
    var dict: [String:Self] = [:]
    for  (key,subJson):(String,JSON) in json{
      dict[key] = Self(json: subJson)
    }
    return dict
  }

  public static func intObjectsMapFrom(dict json:JSON) -> [Int:Self]{
    var dict: [Int:Self] = [:]
    for  (key,subJson):(String,JSON) in json{
      if let intKey = Int(key) {
        dict[intKey] = Self(json: subJson)
      }else{
        assertionFailure("\(key) cannot cast to int")
      }
    }
    return dict
  }

}




public protocol BXModelAware{
    
}

public protocol BXModel:BXModelAware,JSONDeserializable,JSONSerializable{
   
}

// below is legecy code


//@available(*,deprecated, renamed:"JSONDeserializable" , message: "will be removed at next version")
public protocol BXJSONDeserializable{
  init(json:JSON)
}


//@available(*,deprecated, renamed:"JSONSerializable" , message: "will be removed at next version")
public protocol BXJSONSerializable{
  func toDict() -> [String:Any]
}


public extension JSONDeserializable{
    //@available(*,deprecated, renamed:"objectsFrom" , message: "will be removed at next version")
    public static func arrayFrom(_ json:JSON) -> [Self]{
        var array = [Self]()
        for (_,subJson):(String,JSON) in json{
            let item = Self(json:subJson)
            array.append(item)
        }
        return array
    }
}


