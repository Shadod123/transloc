//
//  ApiCallPassageiro.swift
//  TransLoc
//
//  Created by Student08 on 27/04/23.
//

import Foundation

struct Passageiro : Codable, Hashable {
    var nome : String?
    var endereco : String?
    var ordem : String?
}

class ApiCallPassageiro: ObservableObject {
    @Published var chars : [Passageiro] = []
    
    func fetch() {
        guard let url = URL(string: "http://127.0.0.1:1880/getpassageirotl") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Passageiro].self, from: data)
                
                DispatchQueue.main.async {
                    self?.chars = parsed
                }
            } catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func create(passageiro: Passageiro) {
            guard let url = URL(string: "http://127.0.0.1:1880/postpassageirotl") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST" // Método HTTP para criar um novo objeto
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Definir o tipo de conteúdo do corpo da requisição como JSON
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(passageiro) // Codificar o objeto em JSON
                request.httpBody = jsonData // Definir o corpo da requisição como os dados codificados
            } catch {
                print(error)
                return
            }

            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let parsed = try JSONDecoder().decode(Passageiro.self, from: data) // Decodificar a resposta do servidor em um objeto do tipo Usuario

                    DispatchQueue.main.async {
                        self?.chars.append(parsed) // Adicionar o objeto decodificado ao array de objetos
                    }
                } catch {
                    print(error)
                }
            }

            task.resume()
        }
}
