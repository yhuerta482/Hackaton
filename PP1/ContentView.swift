//
//  ContentView.swift
//  PP1
//
//  Created by CEDAM10 on 25/11/24.
//

import SwiftUI
struct Base_datos: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var users: [(id: Int, name: String, email: String)] = []

    var body: some View {
        VStack(spacing: 20) {
            TextField("Nombre", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Correo electrónico", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                DatabaseManager.shared.insertUser(name: name, email: email)
                loadUsers()
            }) {
                Text("Guardar Usuario")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            List(users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text("Nombre: \(user.name)")
                    Text("Correo: \(user.email)")
                    
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
        }
        .onAppear {
            loadUsers()
        }
    }

    private func loadUsers() {
        users = DatabaseManager.shared.fetchUsers()
    }
}

#Preview {
    Base_datos()
}
