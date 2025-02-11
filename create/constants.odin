package create

PROGRAM_VERSION :: "0.0.2"

OLS_FILE_NAME :: "ols.json"
OLS_INSTANCE :: OLS {
    schema = "https://raw.githubusercontent.com/DanielGavin/ols/master/misc/ols.schema.json",
    enable_document_symbols = true,
    enable_hover = true,
    enable_snippets = true,
}

MAIN_ODIN_FILE_NAME :: "main.odin"
MAIN_ODIN_DATA ::
`package main

import "core:fmt"

main :: proc() {
    fmt.println("Hello, World!")
}`

VSCODE_FOLDER_NAME :: ".vscode"
VSCODE_LAUNCH_PROGRAM_CONFIG :: "${workspaceFolder}/"
VSCODE_LAUNCH_PROGRAM_CONFIG_DEFAULT :: "${workspaceFolder}/${workspaceFolderBasename}"
VSCODE_LAUNCH_INSTANCE :: VSCODE_LAUNCH {
    version = "0.2.0",
    configurations = {
        {
            name = "Launch",
            type = "cppdbg",
            request = "launch",
            program = "",
            args = []string{},
            cwd = "${workspaceFolder}"
        }
    }
}
VSCODE_TASKS_INSTANCE :: VSCODE_TASKS {
    version = "2.0.0",
    tasks = {
        {
            label = "Build Release",
            type = "shell",
            command = "odin build .",
            group = {
                kind = "build",
                isDefault = false,
            }
        },
        {
            label = "Build Debug",
            type = "shell",
            command = "odin build . -debug",
            group = {
                kind = "build",
                isDefault = true,
            }
        }
    }
}