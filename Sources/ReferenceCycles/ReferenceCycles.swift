class Account {
    let amount: Double = 0.0
    let currency: String = "BRL"
    weak var client: Client?

    init(client: Client) {
        print ("Account initialized")
        self.client = client
    }

    deinit {
        print ("Account deinitialized")
    }
}

class Client {
    let name: String = ""
    var accounts = [Account]()

    func addAccount(account: Account) {
        accounts.append(account)
    }

    init() {
        print ("Client initialized")
    }

    deinit {
        print ("Client deinitialized")
    }
}

@main
public struct ReferenceCycles {

    public static func main() {

        var client: Client? = Client()
        var account: Account? = Account(client: client!)
        client?.addAccount(account: account!)

        client = nil
        account = nil
    }
}
