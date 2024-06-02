//
//  TelaHomeMotorista.swift
//  TransLoc
//
//  Created by Student04 on 27/04/23.
//

import SwiftUI

struct CardModifierDriver: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct GrupoCardDriver: View {
    // Variaveis do grupo
    let nome : String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Spacer()
                Text(nome)
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(5)
                Spacer()
            }.padding(10)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("StormCloud"))
        .modifier(CardModifierDriver())
        .padding(.horizontal, 10)
    }
}

struct TelaHomeMotorista: View {
    //let grupo : Grupo
    @State private var selection = 0
    
    var body: some View {
        NavigationStack{
                TabView(selection: $selection) {
                    // Home
                    ZStack{
                        Color("WeldonBlue").ignoresSafeArea()
                        VStack {
                            HStack {
                                Spacer()
                                Text("Grupos")
                                    .font(.largeTitle)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }.frame(maxHeight: 50.0)
                            Divider()
                            ScrollView {
                                NavigationLink(destination: GerenciamentoView()) {
                                    GrupoCardDriver(nome: "Grupo A")
                                }
                                NavigationLink(destination: GerenciamentoView()) {
                                    GrupoCardDriver(nome: "Grupo B")
                                }
                                NavigationLink(destination: GerenciamentoView()) {
                                    GrupoCardDriver(nome: "Grupo C")
                                }
                                NavigationLink(destination: GerenciamentoView()) {
                                    GrupoCardDriver(nome: "Grupo D")
                                }
                            }
                        }
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                    .toolbarBackground(Color("WeldonBlue"), for: .tabBar)
                    
                    // Notificações
                    ZStack {
                        Color("WeldonBlue").ignoresSafeArea()
                        TelaNotificacoes()
                            //.foregroundColor(Color.white)
                    }
                    .tabItem {
                        Image(systemName: "exclamationmark.circle.fill")
                        Text("Notificações")
                    }
                    .tag(1)
                    .toolbarBackground(Color("WeldonBlue"), for: .tabBar)
                    
                    // Mapa
                    ZStack {
                        Color("WeldonBlue").ignoresSafeArea()
                        Text("Monitoramento")
                            .foregroundColor(Color.white)
                    }
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Mapa")
                    }
                    .tag(2)
                    .toolbarBackground(Color("WeldonBlue"), for: .tabBar)
                    
                    // Perfil
                    ZStack {
                        Color("WeldonBlue").ignoresSafeArea()
                        Text("Perfil")
                            .foregroundColor(Color.white)
                    }
                    .tabItem {
                        Image(systemName: "person")
                        Text("Perfil")
                    }
                    .tag(3).toolbarBackground(Color("WeldonBlue"), for: .tabBar)
                }.onAppear() {
                    UITabBar.appearance().backgroundColor = .lightText
                }
                .accentColor(Color("SunsetOrange"))
        }
    }
}

struct TelaHomeMotorista_Previews: PreviewProvider {
    static var previews: some View {
        TelaHomeMotorista()
    }
}
