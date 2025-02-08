# ODIN Project Creator

> [ENG](#eng) / [RUS](#rus)

## ENG

A simple program for creating a minimal project in `Odin` language, with the optional ability to create an `ols.json` configuration file for the language server, as well as `launch.json` and `tasks.json` configurations for `VSCode`.

The program is written in Odin, so a ready-to-use Odin compiler is required. The program was tested only on Linux (Linux Mint 22.1 Xia).

To compile the program, enter the following commands:

> The following commands are written for Linux

```bash
git clone https://github.com/danredtmf/odin-project-creator.git
cd ./odin-project-creator
odin build . -o:speed
```

After compilation, the program will be called `odin-project-creator`.

For example, you can put this program somewhere in a folder, add it to `$PATH` and create an alias:

```bash
# Add an alias
alias odin-create-project="odin-project-creator"

# Add the program to $PATH
export PATH=${HOME}/program/folder/path:$PATH

# Example
export PATH=${HOME}/Programs/odin-project-creator:$PATH
```

### Usage

```bash
odin-project-creator <project-name> ["ols"/any] ["vscode"/any]
```

### Options

1. `<project-name>` is required;
2. `[“ols”/any]` - creates `ols.json` (optional);
3. `[“vscode”/any]` - creates `.vscode` folder with `launch.json` and `tasks.json` files (optional).

### Examples

```bash
# Create a `hello` project with `ols.json` and files for VSCode
odin-project-creator hello ols vscode

# Create a `hello` project with `ols.json` but without files for VSCode
odin-project-creator hello ols

# Create a `hello` project without `ols.json` but with files for VSCode
odin-project-creator hello - vscode
```

## RUS

Простая программа для создания минимального проекта на языке `Odin`, с опциональной возможностью создать конфигурационный файл `ols.json` для языкового сервера, а также конфигурации `launch.json` и `tasks.json` для `VSCode`.

Программа написана на Odin, поэтому требуется готовый к работе компилятор Odin. Программа тестировалась только на Linux (Linux Mint 22.1 Xia).

Чтобы скомпилировать программу, введите следующие команды:

> Следующие команды написаны для Linux

```bash
git clone https://github.com/danredtmf/odin-project-creator.git
cd ./odin-project-creator
odin build . -o:speed
```

После компиляции программа будет называться `odin-project-creator`.

Например, можно поместить данную программу куда-нибудь в папку, добавить её в `$PATH` и создать синоним:

```bash
# Добавить псевдоним
alias odin-create-project="odin-project-creator"

# Добавить программу в $PATH
export PATH=${HOME}/program/folder/path:$PATH

# Пример
export PATH=${HOME}/Programs/odin-project-creator:$PATH
```

### Использование

```bash
odin-project-creator <название-проекта> ["ols"/any] ["vscode"/any]
```

### Параметры

1. `<название-проекта>` - обязательный;
2. `["ols"/any]` - создаёт `ols.json` (опционально);
3. `["vscode"/any]` - создаёт папку `.vscode` с файлами `launch.json` и `tasks.json` (опционально).

### Примеры

```bash
# Создание проекта `hello` с `ols.json` и с файлами для VSCode
odin-project-creator hello ols vscode

# Создание проекта `hello` с `ols.json`, но без файлов для VSCode
odin-project-creator hello ols

# Создание проекта `hello` без `ols.json`, но с файлами для VSCode
odin-project-creator hello - vscode
```