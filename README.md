# MyApp

Aplicativo Android de contador construído com Kotlin + Jetpack Compose.
Build automatizado com GitHub Actions rodando em Ubuntu.

---

## Requisitos

- Android Studio (qualquer versão recente)
- Android 8.0+ (API 26+) para rodar no device

---

## Como rodar localmente

### No emulador (Windows/Mac/Linux)

1. Instale o [Android Studio](https://developer.android.com/studio)
2. Abra a pasta `my-first-app` no Android Studio
3. Aguarde o sync do Gradle
4. Menu → Tools → Device Manager → crie um emulador (ex: Pixel 8, API 35)
5. Pressione ▶

### No seu Android (cabo USB)

1. No celular: **Configurações → Sobre o telefone → toque 7x em "Número da versão"**
   (ativa o Modo Desenvolvedor)
2. **Configurações → Opções do desenvolvedor → Depuração USB → ativar**
3. Conecte o cabo USB
4. No Android Studio, selecione seu dispositivo na barra de targets
5. Pressione ▶

### Instalar o APK diretamente (sem Android Studio)

Após o build no GitHub Actions, baixe o artefato `MyApp-debug.apk` e:
- Transfira para o celular (cabo, WhatsApp, Google Drive, etc.)
- No celular, abra o arquivo e instale
- Se pedir permissão para "instalar apps desconhecidos", autorize

---

## Pipeline GitHub Actions

### Workflow 1 — Auto Pull Request

[.github/workflows/auto-pr.yml](.github/workflows/auto-pr.yml)

Antes de usar, habilite no repositório:
```
Settings → Actions → General → Workflow permissions
  ● Read and write permissions
  ☑ Allow GitHub Actions to create and approve pull requests
```

| Push em | Abre PR para |
|---------|-------------|
| Qualquer branch (exceto `develop` e `main`) | `develop` |
| `develop` | `main` |

### Workflow 2 — Android Build

[.github/workflows/android-build.yml](.github/workflows/android-build.yml)

Roda em todo push e PR. Compila o APK de debug e publica como artefato.

```
Runner:   ubuntu-latest (sem necessidade de macOS)
Build:    gradle assembleDebug
Artefato: app-debug.apk — retido por 7 dias
```

### Fluxo completo

```
feature/xyz ──push──▶ PR automático → develop
                      build APK (validação)

develop ──merge──▶ PR automático → main
                   build APK

main ──merge──▶ build APK (release candidate)
```

---

## Estrutura do projeto

```
my-first-app/
├── .github/workflows/
│   ├── android-build.yml       Pipeline de build
│   └── auto-pr.yml             PRs automáticos
├── app/
│   ├── src/main/
│   │   ├── java/com/example/myapp/
│   │   │   └── MainActivity.kt  Tela do contador (Jetpack Compose)
│   │   ├── res/values/
│   │   │   ├── strings.xml
│   │   │   └── themes.xml
│   │   └── AndroidManifest.xml
│   ├── build.gradle.kts         Config do módulo app
│   └── proguard-rules.pro
├── gradle/wrapper/
│   └── gradle-wrapper.properties
├── build.gradle.kts             Config raiz do projeto
├── settings.gradle.kts          Módulos e repositórios
├── .gitignore
└── README.md
```

---

## Histórico

| Data | Alteração |
|------|-----------|
| 2026-05-25 | Criação inicial como app iOS (SwiftUI) |
| 2026-05-25 | Code signing e pipeline TestFlight (iOS) |
| 2026-05-25 | Workflow de PRs automáticos |
| 2026-05-25 | Migração completa para Android (Kotlin + Jetpack Compose) |
