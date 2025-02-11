package main

import "core:os"
import "core:fmt"
import "core:flags"
import "core:slice"
import "core:strings"

import "create"

OPTIONS :: struct {
    name: string  `args:"pos=0,required" usage:"Project name."`,
    ols: bool     `usage:"Creates 'ols.json' (optional)."`,
    vscode: bool  `usage:"Creates '.vscode' folder with 'launch.json' and 'tasks.json' files (optional)."`,
    version: bool `usage:"Show program version."`,
}

main :: proc() {
    opt: OPTIONS
    style: flags.Parsing_Style = .Unix
    flags.parse_or_exit(&opt, os.args, style)

    project_name: string
    project_path_local_slice: []string
    ols_path_local_slice: [dynamic]string
    main_odin_local_slice: [dynamic]string
    vscode_config_local_slice: [dynamic]string

    defer delete(ols_path_local_slice)
    defer delete(main_odin_local_slice)
    defer delete(vscode_config_local_slice)

    if opt.version {
        fmt.printfln(create.PROGRAM_VERSION)
        os.exit(0)
    }

    if len(opt.name) < 1 {
        fmt.eprintln("The parameter `<project-name>` must be the name of the project!\nType `--help` for more info.")
        os.exit(0)
    } else {
        project_name = opt.name
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

    if opt.ols {
        create.ols(&ols_path_local_slice)
    }

    if opt.vscode {
        create.vscode_config(&vscode_config_local_slice)
    }

    fmt.println("The project has been created!")
}

