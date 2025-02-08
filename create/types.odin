package create

OLS :: struct {
    schema: string,
    enable_document_symbols: bool,
    enable_hover: bool,
    enable_snippets: bool,
}

VSCODE_TASK_GROUP :: struct {
    kind: string,
    isDefault: bool,
}

VSCODE_TASK :: struct {
    label: string,
    type: string,
    command: string,
    group: VSCODE_TASK_GROUP,
}

VSCODE_TASKS :: struct {
    version: string,
    tasks: []VSCODE_TASK,
}

VSCODE_LAUNCH_CONFIG :: struct {
    name: string,
    type: string,
    request: string,
    program: string,
    args: []string,
    cwd: string,
}

VSCODE_LAUNCH :: struct {
    version: string,
    configurations: []VSCODE_LAUNCH_CONFIG,
}