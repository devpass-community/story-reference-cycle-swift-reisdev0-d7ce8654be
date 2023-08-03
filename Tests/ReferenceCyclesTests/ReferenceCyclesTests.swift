import XCTest
@testable import ReferenceCycles

class AccountInstance: Account {
    
    static var count: Int = 0
    
    override init(client: Client) {
        super.init(client: client)
        AccountInstance.count += 1
    }

    deinit {
        AccountInstance.count -= 1
    }
}

class ClientInstance: Client {
    
    static var count: Int = 0
    
    override init() {
        super.init()
        ClientInstance.count += 1
    }

    deinit {
        ClientInstance.count -= 1
    }
}

final class ReferenceCyclesTests: XCTestCase {
    func testDeinit() throws {
        
        var client: ClientInstance? = ClientInstance()
        var account: AccountInstance? = AccountInstance(client: client!)
        client?.addAccount(account: account!)

        client = nil
        account = nil

        XCTAssertEqual(ClientInstance.count, 0, "Client deinit was not called")
        XCTAssertEqual(AccountInstance.count, 0, "Account deinit was not called")
    }
}
