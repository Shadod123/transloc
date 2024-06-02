//
//  GerenciamentoView.swift
//  TransLoc
//
//  Created by Student04 on 08/05/23.
//

import SwiftUI

struct GerenciamentoView: View {
    let passageiros = [
        PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 1),
        PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 2),
        PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 3),
        PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 4),
        PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 5)]
    
    var body: some View {
        TabView {
            GerenciamentoClientes(passageiros: passageiros)
                .tabItem{
                    Label("Passageiros", systemImage: "person.circle.fill")
                }
            PartidaView(passageiros: passageiros)
                .tabItem{
                    Label("Avisar Partida", systemImage: "paperplane.circle.fill")
                }
            FinalizarView(passageiros: passageiros)
                .tabItem{
                    Label("Marcar Chegada", systemImage: "checkmark.shield.fill")
                }
        }.onAppear() {
            UITabBar.appearance().backgroundColor = .lightText
        }
        .accentColor(Color("SunsetOrange"))
    }
}

struct GerenciamentoView_Previews: PreviewProvider {
    static var previews: some View {
        GerenciamentoView()
    }
}
