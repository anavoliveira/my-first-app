# MyApp

Aplicativo iOS de contador construído com SwiftUI. Inclui pipeline completo
de CI/CD com GitHub Actions rodando em macOS, com build para simulador e
deploy automático para TestFlight.

---

## Requisitos

- Xcode 16+
- iOS 17+
- Swift 5.0
- Conta no Apple Developer Program (para deploy ao TestFlight)

---

## Como abrir localmente

```bash
open MyApp.xcodeproj
```

Selecione um simulador iPhone na barra de targets do Xcode e pressione ▶.

---

## Pipeline GitHub Actions

O workflow em [.github/workflows/ios-build.yml](.github/workflows/ios-build.yml)
é ativado automaticamente em pushes para `main` e `develop`, e em pull requests
para `main`.

### Job 1 — Build (Simulador)

Roda em **todo push e PR**. Compila para o simulador iOS sem code signing.
Serve como validação rápida de que o código compila sem erros.

```
Runner: macos-15
SDK: iphonesimulator
Signing: CODE_SIGNING_ALLOWED=NO
Artefato: MyApp.app (simulador) — retido por 7 dias
```

### Job 2 — Deploy to TestFlight

Roda **somente em push para `main`**, após o Job 1 passar. Assina o app com
o certificado de distribuição e envia ao App Store Connect (fila do TestFlight).

```
Runner: macos-15
SDK: iphoneos (device real)
Signing: certificado Apple Distribution + provisioning profile
Destino: TestFlight via App Store Connect API
```

---

## Configuração do Code Signing

Para o deploy ao TestFlight funcionar, configure os seguintes secrets no
repositório GitHub (`Settings → Secrets and variables → Actions`):

| Secret | Descrição |
|--------|-----------|
| `BUILD_CERTIFICATE_BASE64` | Certificado .p12 em base64 |
| `P12_PASSWORD` | Senha do .p12 |
| `BUILD_PROVISION_PROFILE_BASE64` | Provisioning profile .mobileprovision em base64 |
| `KEYCHAIN_PASSWORD` | Senha aleatória para o keychain temporário do CI |
| `TEAM_ID` | Apple Developer Team ID (ex: `ABC1234XYZ`) |
| `APP_STORE_CONNECT_KEY_ID` | Key ID da API do App Store Connect |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID da API do App Store Connect |
| `APP_STORE_CONNECT_API_KEY` | Arquivo .p8 da API key em base64 |

> Para instruções detalhadas de como obter cada valor, consulte o arquivo
> `.developer` (não versionado — apenas local).

### Converter arquivos para base64

**macOS/Linux:**
```bash
base64 -i Certificates.p12 | pbcopy
base64 -i MyApp.mobileprovision | pbcopy
base64 -i AuthKey_KEYID.p8 | pbcopy
```

**Windows (PowerShell):**
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("Certificates.p12")) | Set-Clipboard
```

---

## Estrutura do projeto

```
my-first-app/
├── .github/workflows/ios-build.yml   Pipeline CI/CD
├── MyApp.xcodeproj/project.pbxproj   Projeto Xcode
├── MyApp/
│   ├── MyAppApp.swift                 Entry point (@main)
│   ├── ContentView.swift              Tela do contador
│   └── Assets.xcassets/              AppIcon e AccentColor
├── ExportOptions.plist               Configuração do export (App Store)
├── .gitignore
└── README.md
```

---

## Histórico

| Data | Alteração |
|------|-----------|
| 2026-05-25 | Criação inicial: app SwiftUI contador + build no simulador |
| 2026-05-25 | Code signing completo + pipeline de deploy TestFlight |
