//
//  ContentView.swift
//  PP1
//
//  Created by CEDAM10 on 25/11/24.
//

import SwiftUI

struct Menu_deplegable: View {
    @State private var isMenuOpen: Bool = false // Estado para controlar el menú

        var body: some View {
            ZStack {
                // Contenido principal
                VStack {
                    Text("Contenido Inicial de la Pagina")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.white)

                // Botón para abrir el menú
                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle() // Abre/cierra el menú
                        }
                    }) {
                        Text("Abrir Menú")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(5)
                }

                // Menú deslizable
                if isMenuOpen {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("")
                            Text("Menú desplegable")
                                .font(.headline)
                                .padding(.top, 40)

                            // Ejemplo de opciones
                            Button("Opción 1") {
                                print("Opción 1 seleccionada")
                            }
                            Button("Opción 2") {
                                print("Opción 2 seleccionada")
                            }

                            Spacer() // Empuja los elementos hacia arriba
                        }
                        .frame(width: 300)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                        Spacer() // Espacio restante de la pantalla
                    }
                    .background(Color.black.opacity(0.3)) // Fondo semi-transparente
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false // Cierra el menú al tocar fuera
                        }
                    }
                    .ignoresSafeArea()// Importante pues se ve cortado sin el
                }
            }
        }
    }
#Preview {
    Menu_deplegable()
}


struct ContentView: View {
    @State private var selectedOption: String = "Selecciona una opción"

    var body: some View {
        VStack(spacing: 20) {
            Text("Seleccionar Opciones")
                .font(.headline)

            Menu {
                Button("Opción 1") {
                    selectedOption = "Opción 1 seleccionada"
                }
                Button("Opción 2") {
                    selectedOption = "Opción 2 seleccionada"
                }
                Button("Opción 3") {
                    selectedOption = "Opción 3 seleccionada"
                }
            } label: {
                Label("Opciones", systemImage: "chevron.down")
                    .font(.title2)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }

            Text("Has seleccionado: \(selectedOption)")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
