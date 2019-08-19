//
//  IMGDataModelTest.swift
//  GranularTestTests
//
//  Created by manoj budumuru on 8/18/19.
//  Copyright © 2019 manoj budumuru. All rights reserved.
//

import XCTest
@testable import GranularTest

class IMGDataModelTest: XCTestCase {
    
    var dataModel : IMGDataModel?
    let nameArray : [String] = ["One","Two","Three"]
    let urlArray : [String] = ["Icons/1.png","Icons/2.png","Icons/3.png"]
    
    let persistedData : [[String : String]] = [["name" : "One","url" : "Icons/1.png"],
                                               ["name" : "Two","url" : "Icons/2.png"],
                                               ["name" : "Three","url" : "Icons/3.png"]]
    
    override func setUp() {
        super.setUp()
        self.dataModel = IMGDataModel()
    }
    
    override func tearDown() {
        super.tearDown()
        self.dataModel = nil
    }
    
    func testDataModelWithEmptyValue() {
        self.dataModel?.initWith(imageJsonResponce: [[:]])
        XCTAssert(self.dataModel!.imageNameArray.isEmpty == true)
        XCTAssert(self.dataModel!.imageURLArray.isEmpty == true)
    }
    
    func testDataModelWithPersistedValue() {
        self.dataModel?.initWith(imageJsonResponce: self.persistedData)
        XCTAssert(self.dataModel!.imageNameArray.isEmpty == false)
        XCTAssert(self.dataModel!.imageNameArray == self.nameArray)
        XCTAssert(self.dataModel!.imageURLArray.isEmpty == false)
        XCTAssert(self.dataModel!.imageURLArray == self.urlArray)
    }
    
}
