//
//  GerenciamentoClientes.swift
//  TransLoc
//
//  Created by Student08 on 29/04/23.
//

import SwiftUI

struct CardModifier1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
    
}

struct PassageiroCard: View {
    // Variaveis do passageiro
    let nome : String
    let endereco : String
    let ordem : Int
    // Variaveis da struct
    @State var chegou : Bool = false
    @State var atrasou : Bool = false
    @State var faltara : Bool = false
    @State var pego : Bool = false
    // Alertas de confirmacao
    @State var sConfirmationC : Bool = false
    @State var sConfirmationA : Bool = false
    @State var sConfirmationF : Bool = false
    @State var sConfirmationP : Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Spacer()
                Text("\(ordem) - \(nome)")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(endereco)
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                
                HStack {
                    VStack{
                        Image(systemName:  "checkmark.circle.fill")
                            .foregroundColor(chegou ? .green : .gray)
                        Text("Chegou")
                            .foregroundColor(chegou ? .green : .gray)
                    } .onTapGesture {
                        sConfirmationC = true
                    } .confirmationDialog("Selecionar Chegou", isPresented: $sConfirmationC) {
                        Button("Selecionar Chegou") {
                            chegou = true
                            atrasou = false
                            faltara = false
                            pego = false
                        }
                        Button("Cancelar!", role: .cancel) {}
                    } message: {
                        Text("Confirmar Alteração?")
                    }
                    Spacer()
                    VStack{
                        Image(systemName:  "clock.fill")
                            .foregroundColor(atrasou ? .yellow : .gray)
                        Text("Atrasou")
                            .foregroundColor(atrasou ? .yellow : .gray)
                    } .onTapGesture {
                        sConfirmationA = true
                    } .confirmationDialog("Selecionar Atrasou", isPresented: $sConfirmationA) {
                        Button("Selecionar Atrasou") {
                            chegou = false
                            atrasou = true
                            faltara = false
                            pego = false
                        }
                        Button("Cancelar!", role: .cancel) {}
                    } message: {
                        Text("Confirmar Alteração?")
                    }
                    Spacer()
                    VStack{
                        Image(systemName:  "xmark.octagon.fill")
                            .foregroundColor(faltara ? .red : .gray)
                        Text("Faltará")
                            .foregroundColor(faltara ? .red : .gray)
                    } .onTapGesture {
                        sConfirmationF = true
                    } .confirmationDialog("Selecionar Faltará", isPresented: $sConfirmationF) {
                        Button("Selecionar Faltará") {
                            chegou = false
                            atrasou = false
                            faltara = true
                            pego = false
                        }
                        Button("Cancelar!", role: .cancel) {}
                    } message: {
                        Text("Confirmar Alteração?")
                    }
                    
                    Spacer()
                    VStack{
                        Image(systemName:  "car.circle.fill")
                            .foregroundColor(pego ? .green : .gray)
                        
                        Text("Pego")
                            .foregroundColor(pego ? .green : .gray)
                    } .onTapGesture {
                        sConfirmationP = true
                    } .confirmationDialog("Selecionar Pego", isPresented: $sConfirmationP) {
                        Button("Selecionar Pego") {
                            chegou = false
                            atrasou = false
                            faltara = false
                            pego = true
                        }
                        Button("Cancelar!", role: .cancel) {
                            
                        }
                    } message: {
                        Text("Confirmar Alteração?")
                    }
                }.padding(.top, 10.0)
                Spacer()
            }.padding(15.0)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("StormCloud"))
        .modifier(CardModifier1())
        .padding(.all, 10)
    }
}

struct GerenciamentoClientes: View {
    // States
    @State var sInicar : Bool = false
    @State var sFinalizar : Bool = false
    @State var sOrdem : Bool = false
    //let grupo : Grupo
    let passageiros : [PassageiroCard]
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    /*
                    AsyncImage (url: URL(string: "https://i.scdn.co/image/ab67616d0000b27377335ddf45a3651579cde851"), scale: 15.0)
                        .clipShape(Circle())
                     */
                    Spacer()
                    Text("Nome do Grupo")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                    Spacer()
                }.frame(maxHeight: 50.0)
                Divider()
                ScrollView {
                    ForEach(passageiros, id: \.ordem) { passageiro in
                        passageiro
                    }
                }
            }
        }.padding().background(Color("WeldonBlue"))
    }
}

struct GerenciamentoClientes_Previews: PreviewProvider {
    static var previews: some View {
        let passageiros = [
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 1),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 2),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 3),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 4),
            PassageiroCard(nome: "Daniel Valadares de Souza Felix", endereco: "Rua Puc Minas Coracao Eucaristico", ordem: 5)]
        GerenciamentoClientes(passageiros: passageiros)
    }
}
