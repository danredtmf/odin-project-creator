package main

import "core:os"
import "core:fmt"
import "core:slice"
import "core:strings"

import "create"

main :: proc() {
    project_name: string
    project_path_local_slice: []string
    ols_path_local_slice: [dynamic]string
    main_odin_local_slice: [dynamic]string
    vscode_config_local_slice: [dynamic]string

    defer delete(ols_path_local_slice)
    defer delete(main_odin_local_slice)
    defer delete(vscode_config_local_slice)

    if len(os.args) > 1 {
        if os.args[1] == "-h" || os.args[1] == "--help" {
            fmt.printfln(create.PROGRAM_HELP_TEXT, create.PROGRAM_VERSION)
            os.exit(1)
        } else {
            project_name = os.args[1]
        }
    } else {
        fmt.eprintln("The parameter `<project-name>` must be the name of the project!\nType `-h` or `--help` for more info.")
        os.exit(1)
    }
    
    project_path_local_slice = {"./", project_name}

    ols_path_local_slice = slice.clone_to_dynamic(project_path_local_slice)
    main_odin_local_slice = slice.clone_to_dynamic(project_path_local_slice)
    vscode_config_local_slice = slice.clone_to_dynamic(project_path_local_slice)
    
    append(&ols_path_local_slice, "/")
    append(&ols_path_local_slice, create.OLS_FILE_NAME)
    append(&main_odin_local_slice, "/")
    append(&main_odin_local_slice, create.MAIN_ODIN_FILE_NAME)
    append(&vscode_config_local_slice, "/")
    append(&vscode_config_local_slice, create.VSCODE_FOLDER_NAME)
    
    create.folder(&project_path_local_slice)
    create.main_file(&main_odin_local_slice)

    if len(os.args) > 2 {
        switch os.args[2] {
            case "ols":
                create.ols(&ols_path_local_slice)
        }
    }

    if len(os.args) > 3 {
        switch os.args[3] {
            case "vscode":
                create.vscode_config(&vscode_config_local_slice, &project_name)
        }
    }

    fmt.println("The project has been created!")
}

