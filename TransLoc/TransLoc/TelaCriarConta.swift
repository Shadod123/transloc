//
//  TelaCriarConta.swift
//  TransLoc
//
//  Created by Student07 on 24/04/23.
//

import SwiftUI

struct TelaCriarConta: View {
    @StateObject private var usuario = ApiCallUsuario()
    // Declaração de variáveis
    @State var email: String = ""
    @State var senha: String = ""
    @State var senha2: String = ""
    @State var nome: String = ""
    @State var motorista: String = ""
    
    @State var user: Usuario = Usuario( name: "nome", email: "email", password: "err", motorista: false )
    
    @State private var showingSuccessAlert = false
    @State private var showingErrorAlert = false
    @State private var showingErrorAlert2 = false
    @State private var showingErrorAlert3 = false
    @State private var goToLogin = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Criar Conta")
                        .font(.system(size: 72))
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Group {
                        TextField("Nome", text: $nome)
                        TextField("E-mail", text: $email)
                        SecureField("Senha", text: $senha)
                        SecureField("Confirmar senha", text: $senha2)
                        TextField("Tipo de Conta (Cliente ou Motorista)", text: $motorista)
                            
                        
                            
                    }.padding(.horizontal, 20.0)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .autocapitalization(.none)

                    if goToLogin == true {
                        NavigationLink("Fazer Login") {
                            ContentView()
                        }.padding(.top, 50.0).font(.title)
                    }

                    Spacer()
                    
                    ZStack(alignment:  .bottomTrailing) {
                        
                        
                        Circle()
                            .foregroundColor(Color("StormCloud"))
                            .frame(width: 100, height: 100)
                        Button("Confirmar") {
                            confirm()
                        }
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .alert("Conta Criada com Sucesso!", isPresented: $showingSuccessAlert) {
                                Button("Ok", role: .cancel){}
                            }
                            .alert("Senhas incompatíveis", isPresented: $showingErrorAlert) {
                                Button("Ok", role: .cancel){}
                            }
                            .alert("Por favor, digite cliente ou motorista.", isPresented: $showingErrorAlert2) {
                                Button("Ok", role: .cancel){}
                            }
                            .alert("Preencha todos os campos.", isPresented: $showingErrorAlert3) {
                                Button("Ok", role: .cancel){}
                            }
                            
                    }
                    
                  
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("WeldonBlue"))
            
        }.tint(Color("SunsetOrange"))
        
        
    }
    
    func confirm() -> Void{
        user.name = nome
        user.email = email
        motorista = motorista.lowercased()
        if nome != "" && email != "" && senha != ""  {
            if senha == senha2{
                if motorista == "motorista" {
                    showingSuccessAlert = true
                    goToLogin = true
                    user.password = senha
                    user.motorista = true
                    usuario.create(usuario: user)
                } else if motorista == "cliente" {
                    showingSuccessAlert = true
                    goToLogin = true
                    user.password = senha
                    user.motorista = false
                    usuario.create(usuario: user)
                } else {
                    showingErrorAlert2 = true
                }
            } else {
                showingErrorAlert = true
            }
            
            
        } else {
            showingErrorAlert3 = true
        }
        
        
        
    
    }
}

struct TelaCriarConta_Previews: PreviewProvider {
    static var previews: some View {
        TelaCriarConta()
    }
}
