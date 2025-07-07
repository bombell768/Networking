import Foundation

struct User: Decodable {
    let email: String
}

func fetchUsers(completion: @escaping @Sendable ([User]) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
        print("Invalid URL")
        completion([])
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching users: \(error)")
            completion([])
            return
        }

        guard let data = data else {
            print("No data received")
            completion([])
            return
        }

        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            completion(users)
        } catch {
            print("Failed to decode JSON: \(error)")
            completion([])
        }
    }.resume()
}

func printUserEmails(from users: [User]) {
    for user in users {
        print(user.email)
    }
}

fetchUsers { users in
    printUserEmails(from: users)
}
