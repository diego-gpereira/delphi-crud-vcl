# Sistema Desktop CRUD com Delphi VCL

![Plataforma](https://img.shields.io/badge/Plataforma-Windows-blue?style=for-the-badge&logo=windows)
![Framework](https://img.shields.io/badge/Framework-VCL-blue?style=for-the-badge&logo=delphi)
![Banco de Dados](https://img.shields.io/badge/Banco-Firebird-red?style=for-the-badge&logo=firebird)

Aplicação desktop para Windows, demonstrando um sistema CRUD (Create, Read, Update, Delete) completo para gerenciamento de pessoas. O projeto foi desenvolvido com Delphi 12 e a tradicional e robusta framework VCL (Visual Component Library).

**Status do Projeto:** Concluído ✔️

---

## 💡 Conceitos e Arquitetura

* **Aplicação Desktop Nativa:** Construído com VCL para garantir máxima performance e integração com o sistema operacional Windows.
* **Arquitetura Cliente-Servidor:** O sistema se conecta diretamente a um banco de dados Firebird, demonstrando o padrão clássico de aplicações de gestão.
* **Camada de Acesso a Dados:** Utilização de um DataModule central para gerenciar a conexão e as queries ao banco de dados, organizando o acesso aos dados.

---

## 🛠️ Tecnologias Utilizadas

* **IDE:** RAD Studio 12.3 (Delphi 12 Athens)
* **Framework UI:** Visual Component Library (VCL)
* **Linguagem:** Object Pascal
* **Banco de Dados:** Firebird
* **Acesso a Dados:** FireDAC
* **Linguagem de Consulta:** SQL

---

## 🚀 Setup e Execução

1.  **Pré-requisitos:**
    * Ter o Delphi 12 (RAD Studio 12.3) instalado.
    * Ter um servidor Firebird ativo na sua máquina.

2.  **Passos:**
    * Clone este repositório.
    * Abra o arquivo do projeto (`.dproj`) no Delphi.
    * Garanta que o arquivo do banco de dados (`.fdb`) esteja acessível e que a string de conexão no componente `TFDConnection` (dentro do DataModule) esteja configurada corretamente com o caminho e as credenciais do seu banco.
    * Compile (Build) e Execute (Run) o projeto a partir da IDE.