" Vim compiler file
" Compiler:         Arduino IDE command line

if exists("current_compiler")
  finish
endif
let current_compiler = "arduino"

let s:cpo_save = &cpo
set cpo&vim

if !exists('g:compiler_arduino_command')
    if executable('arduino_debug')  " if there is arduino command in path, use it
        let g:compiler_arduino_command='arduino_debug'
    elseif executable('arduino')
        let g:compiler_arduino_command='arduino'
    elseif has("win64") " guess arduino command line path
        let g:compiler_arduino_command='c:/Program Files (x86)/Arduino/arduino_debug.exe'
    elseif has("win32")
        let g:compiler_arduino_command='c:/Program Files/Arduino/arduino_debug.exe'
    else
        let g:compiler_arduino_command='arduino'
    endif
endif

CompilerSet errorformat=
      \%f:%l:\ %trror:\ %m,
      \%f:%l:\ %tarning:\ %m,
      \%f:%l:\ %m

execute 'CompilerSet makeprg=\"' . escape(substitute(g:compiler_arduino_command, '/', '\\', 'g'), ' ') . '\"\ --verify\ \"%:p:h/%:p:h:t.ino\"'

let &cpo = s:cpo_save
unlet s:cpo_save
