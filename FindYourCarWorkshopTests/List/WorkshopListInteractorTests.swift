//
//  WorkshopListInteractorTests.swift
//  WorkshopListInteractorTests
//
//  Created by Ana Carolina Silva on 25/07/19.
//  Copyright © 2019 Ana Carolina Silva. All rights reserved.
//

import XCTest
import Moya
@testable import FindYourCarWorkshop

class WorkshopListInteractorTests: XCTestCase {

    var provider: MoyaProvider<GoogleAPI>!
    var subject: WorkshopListInteractor!
    let workshopListInteractorOutput = FakeInteractionOutput()
    let kDefaultLocation = Location(0, 0)
    static var workshopData: Data {
        let bundle = Bundle(for: WorkshopListInteractorTests.self)
        let url = bundle.url(forResource: "workshop-list", withExtension: "json")
        return try! Data(contentsOf: url!)
    }
    
    // MARK: - Configure Test
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    class FakeInteractionOutput: WorkshopListInteractorOutputProtocol {
        var workshops: [Workshop]?
        var errorMessage: String?
        
        func handleSuccess(with results: [Workshop]) {
            self.workshops = results
        }
        
        func handleFailure(with message: String) {
            self.errorMessage = message
        }
    }
    
    struct StubWorkshopListResult {
        static let googleRequestDeniedError: MoyaError = MoyaError.requestMapping(GoogleStatusResult.requestDenied.errorDescription)
        static let statusCode404Error: MoyaError = MoyaError.statusCode(Response(statusCode: 404, data: Data()))
        static let jsonMappingError: MoyaError = MoyaError.jsonMapping(Response(statusCode: 200, data: Data()))
        static let successfulResult: [Workshop] = StubWorkshopListResult.workshops
        static let workshops = try! JSONDecoder().decode(GooglePlaceResults<Workshop>.self, from: workshopData).results
    }
    
    // MARK: - Tests
    func testFetchCarWorkshopListWithGoogleError() {
        provider = MoyaProvider<GoogleAPI>(endpointClosure: successEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        let googleClient = GoogleAPIManager.shared
        googleClient.provider = provider
        subject = WorkshopListInteractor(client: googleClient)
        subject.output = workshopListInteractorOutput
        
        subject.fetchCarWorkshopList(near: kDefaultLocation)
        
        guard let workshopsCaughtInInteractionOutputProtocol = workshopListInteractorOutput.workshops else {
            XCTFail("Output has caught no car workshops")
            return
        }
        
        XCTAssertEqual(workshopsCaughtInInteractionOutputProtocol, StubWorkshopListResult.successfulResult)
    }
    
    func testFetchCarWorkshopListWithStatusCode404() {
        provider = MoyaProvider<GoogleAPI>(endpointClosure: statusCodeErrorEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        let googleClient = GoogleAPIManager.shared
        googleClient.provider = provider
        subject = WorkshopListInteractor(client: googleClient)
        subject.output = workshopListInteractorOutput
        
        subject.fetchCarWorkshopList(near: kDefaultLocation)
        
        guard let errorMessageCaughtInInteractionOutputProtocol = workshopListInteractorOutput.errorMessage else {
            XCTFail("Output has caught no error message")
            return
        }
        
        XCTAssertEqual(errorMessageCaughtInInteractionOutputProtocol, StubWorkshopListResult.statusCode404Error.errorDescription)
    }
    
    // MARK: - Private Methods
    private func successEndpointClosure(_ target: GoogleAPI) -> Endpoint {
        let workshop = WorkshopListInteractorTests.workshopData
        
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, workshop) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    private func statusCodeErrorEndpointClosure(_ target: GoogleAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(404, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
}
