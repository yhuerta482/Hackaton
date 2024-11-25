//
//  Base2.swift
//  PP1
//
//  Created by CEDAM10 on 25/11/24.
//

import SQLite3
import Foundation

class DatabaseManager {
    static let shared = DatabaseManager() // Singleton para usar la misma instancia en toda la app
    private var db: OpaquePointer? // Puntero a la base de datos

    private init() {
        openDatabase()
    }

    // Abrir o crear la base de datos
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("UserDatabase.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error al abrir la base de datos")
        } else {
            print("Base de datos abierta o creada correctamente en \(fileURL.path)")
        }

        createTable() // Crear tabla si no existe
    }

    // Crear la tabla de usuarios
    private func createTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT
        );
        """

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Tabla creada o ya existe")
            } else {
                print("No se pudo crear la tabla")
            }
        } else {
            print("Error al preparar la consulta CREATE TABLE")
        }
        sqlite3_finalize(statement)
    }

    // Insertar un usuario
    func insertUser(name: String, email: String) {
        let insertQuery = "INSERT INTO Users (name, email) VALUES (?, ?);"

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (email as NSString).utf8String, -1, nil)

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuario insertado correctamente")
            } else {
                print("Error al insertar usuario")
            }
        } else {
            print("Error al preparar la consulta INSERT")
        }
        sqlite3_finalize(statement)
    }

    // Obtener todos los usuarios
    func fetchUsers() -> [(id: Int, name: String, email: String)] {
        let fetchQuery = "SELECT * FROM Users;"
        var statement: OpaquePointer?
        var users: [(id: Int, name: String, email: String)] = []

        if sqlite3_prepare_v2(db, fetchQuery, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = sqlite3_column_int(statement, 0)
                let name = String(cString: sqlite3_column_text(statement, 1))
                let email = String(cString: sqlite3_column_text(statement, 2))
                users.append((id: Int(id), name: name, email: email))
            }
        } else {
            print("Error al preparar la consulta SELECT")
        }
        sqlite3_finalize(statement)
        return users
    }

    // Cerrar la base de datos
    deinit {
        sqlite3_close(db)
    }
}
