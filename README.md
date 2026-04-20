<p align="center">
  <img src="icon3.png" width="120" alt="SharkApp Logo">
</p>

<h1 align="center">🦈 SharkApp</h1>

<p align="center">
  <strong>Ferramenta portátil de administração e manutenção para Windows</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows">
  <img src="https://img.shields.io/badge/python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python">
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/status-stable-brightgreen?style=for-the-badge" alt="Status">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/made%20with-❤️-red?style=flat-square" alt="Made with love">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square" alt="PRs Welcome">
</p>

---

## 📖 Sobre

**SharkApp** é uma ferramenta completa de administração de sistemas Windows, empacotada em um único executável portátil. Desenvolvida com uma interface gráfica moderna (dark theme), ela reúne as tarefas mais comuns de manutenção e diagnóstico em um só lugar — sem necessidade de abrir o CMD, PowerShell ou lembrar comandos complexos.

> Ideal para técnicos de TI, administradores de sistemas e entusiastas que precisam de uma solução rápida e prática no dia a dia.

---

## ✨ Funcionalidades

| # | Ferramenta | Descrição |
|:-:|:-----------|:----------|
| 🔑 | **Ativação (BIOS)** | Obtém a chave OEM da BIOS e ativa o Windows automaticamente via `slmgr.vbs` |
| 🔄 | **Atualizar Aplicativos** | Atualiza todos os programas instalados usando o **Winget** |
| 🔓 | **Ativação Temporária** | Ativação de Windows e Office via **Microsoft Activation Scripts (MAS)** |
| 🧰 | **Reparar Sistema** | Executa **DISM** + **SFC** para reparar arquivos corrompidos do sistema |
| 💽 | **Verificar Disco** | Submenu completo do **CHKDSK** — corrigir erros, recuperar setores, disco específico |
| 🌐 | **Diagnóstico de Rede** | Ipconfig, liberar/renovar IP, ver MAC, ping — tudo em um submenu interativo |
| 📋 | **Criar Inventário** | Gera relatório detalhado de hardware (CPU, RAM, GPU, discos, etc.) e salva em rede |
| ⚙️ | **Chris Titus Tool** | Abre o utilitário avançado do Chris Titus para debloat, tweaks e instalações |

---

## 🎨 Interface

- ☀ Design **dark mode** com tema glassmórfico
- 🎞️ **Loading overlay** animado com spinner ao selecionar uma opção
- ⌨️ **Atalhos de teclado** (teclas `1` a `8`) para acesso rápido
- 📜 Scrollbar customizada integrada ao tema
- 🖥️ Barra de título escura nativa (DWM)
- 📐 Layout responsivo em grid com redimensionamento automático

---

## 🚀 Como Usar

### Opção 1 — Executável Portátil (Recomendado)

1. Baixe o `shark.exe` na aba [Releases](../../releases)
2. Execute como **Administrador** (a elevação é automática)
3. Escolha a opção desejada clicando no card ou pressionando `1`–`8`

> **Nota:** O arquivo `icon3.png` deve estar na mesma pasta que o executável para exibir o ícone no cabeçalho.

### Opção 2 — Executar via Python

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/SharkApp.git
cd SharkApp

# Execute (requer privilégios de Administrador)
python shark.py
```

### Opção 3 — Compilar você mesmo

```bash
# Instale o PyInstaller
pip install pyinstaller

# Compile usando o .spec incluído
pyinstaller --clean shark.spec

# O executável estará em dist/shark.exe
```

---

## 📁 Estrutura do Projeto

```
SharkApp/
├── shark.py          # Código fonte principal
├── shark.spec        # Configuração de build do PyInstaller
├── icon3.ico         # Ícone do executável (.ico)
├── icon3.png         # Ícone exibido no cabeçalho da interface
├── shark.exe         # Executável compilado (portátil)
└── README.md         # Este arquivo
```

---

## 🛠️ Tecnologias

- **Python 3.10+** — Linguagem principal
- **Tkinter** — Interface gráfica nativa (sem dependências externas)
- **PowerShell** — Motor de execução dos scripts de sistema
- **PyInstaller** — Compilação em executável portátil
- **Win32 API (ctypes)** — Elevação de privilégios e tema da barra de título

---

## ⚙️ Requisitos

- **Windows 10/11** (x64)
- **Privilégios de Administrador** (elevação automática ao iniciar)
- **Winget** instalado (para a opção de atualização de aplicativos)

---

## 👥 Autor

| Nome | Papel |
|:-----|:------|
| **Ryan Moore** | Desenvolvedor |

<p align="center">
  <sub>Feito com 🦈 por Ryan, Celso e Gabriel</sub>
</p>
