//
//  NetworkClientTests.swift
//  SolverTests
//
//  Created by hyunjun on 6/23/24.
//

import XCTest

final class NetworkClientTests: XCTestCase {
    
    var mockClient: MockClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockClient()
    }
    
    override func tearDown() {
        mockClient = nil
        super.tearDown()
    }
    
    /// 네트워크 요청 성공 시나리오
    /// - 네트워크 요청이 성공하여 유효한 데이터를 반환
    /// - `JSON` 데이터를 `MockClient` 에 설정
    /// - 반환된 `MockUser` 객체의 속성 `(handle, name, tier)` 이 예상대로 설정되었는지 검증
    func testFetchUserSuccess() async throws {
        let jsonData = """
            {
                "handle": "testuser",
                "userId": "Test User",
                "tier": 1
            }
            """.data(using: .utf8)!
        
        mockClient.data = jsonData
        
        let endpoint = APIEndpoint.fetchUser(userId: "testuser")
        
        do {
            let user: MockUser = try await mockClient.request(endpoint: endpoint)
            XCTAssertEqual(user.handle, "testuser")
            XCTAssertEqual(user.userId, "Test User")
            XCTAssertEqual(user.tier, 1)
        } catch {
            XCTFail("Expected success but got \(error)")
        }
    }
    
    /// 네트워크 요청 실패 시나리오
    /// - 네트워크 요청이 실패하여 오류를 반환
    /// - `MockClient` 에 오류를 설정
    /// - 요청이 실패할 것으로 예상, 성공할 경우 테스트가 실패
    /// - 반환된 오류가 예상된 `NetworkError.invalidResponse` 인지 확인
    func testFetchUserFailure() async throws {
        mockClient.error = NetworkError.invalidResponse
        
        let endpoint = APIEndpoint.fetchUser(userId: "testuser")
        
        do {
            let _: MockUser = try await mockClient.request(endpoint: endpoint)
            XCTFail("Expected failure but succeeded")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }
}
