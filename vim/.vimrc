" ============================================================
" 1. CONFIGURACIÓN BASE
" ============================================================
syntax on
set termguicolors

" ============================================================
" 2. COLORES = GRISES CALMADOS Y MATES
" ============================================================
" No usamos un colorscheme externo (a veces no carga bien y
" Vim cae en el theme por defecto, que es MUY llamativo).
" Definimos nosotros una paleta simple, toda en grises.
set background=dark
colorscheme default

highlight Normal      guifg=#d0d0d0 ctermfg=253 guibg=NONE ctermbg=NONE
highlight Comment     guifg=#666666 ctermfg=241 gui=italic cterm=italic
highlight Constant    guifg=#7fa3ac ctermfg=109
highlight String      guifg=#7fa3ac ctermfg=109
highlight Number      guifg=#7fa3ac ctermfg=109
highlight Statement   guifg=#ab9683 ctermfg=137
highlight Identifier  guifg=#d0d0d0 ctermfg=253
highlight Function    guifg=#d0d0d0 ctermfg=253
highlight Type        guifg=#9aa7ad ctermfg=110
highlight Special     guifg=#9aa7ad ctermfg=110
highlight PreProc     guifg=#8a8a8a ctermfg=245

" ============================================================
" 3. CURSORLINE COMO "SUBRAYADO" (NO FONDO COMPLETO)
" ============================================================
set cursorline
" Línea propia (no fondo completo). Le damos un color "guisp"
" separado del texto para que se note más y se vea más prolija.
highlight CursorLine   guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=#9aa7ad
highlight CursorLineNr guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=#9aa7ad

" Si tu terminal soporta "undercurl" (Kitty, WezTerm, Alacritty
" con parche), esta versión se ve un poco más gruesa/definida
" que el subrayado normal. Para probarla, comentá las 2 líneas
" de arriba y descomentá estas 2:
" highlight CursorLine   guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#9aa7ad
" highlight CursorLineNr guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#9aa7ad

" Reduce el retraso al procesar teclas/escapes, ayuda a que el
" redibujado se sienta menos "cortado" al moverte rápido.
set ttimeoutlen=0

" Que desaparezca mientras escribís (modo inserción)
augroup CursorLineToggle
    autocmd!
    autocmd InsertEnter * setlocal nocursorline
    autocmd InsertLeave * setlocal cursorline
augroup END

" ============================================================
" 4. TRANSPARENCIA TOTAL
" ============================================================
function! TransparentBackground()
    highlight Normal      guibg=NONE ctermbg=NONE
    highlight NonText     guibg=NONE ctermbg=NONE
    highlight LineNr      guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight SignColumn  guibg=NONE ctermbg=NONE
endfunction
autocmd VimEnter,ColorScheme * call TransparentBackground()

" ============================================================
" 5. ESTÉTICA GENERAL
" ============================================================
set shortmess+=I
set laststatus=0
set nonumber
set showcmd

" ============================================================
" 6. PANTALLA DE INICIO
" ============================================================
function! StartScreen()
    if argc() == 0
        " --- LOGO "VIM" (todas las líneas del mismo ancho) ---
        let l:logo = [
        \ '#   #  #####  #   #',
        \ '#   #    #    ## ##',
        \ '#   #    #    # # #',
        \ ' # #     #    #   #',
        \ '  #    #####  #   #',
        \ ]

        " --- GLENDA (mascota de Plan 9), va al costado del logo ---
        let l:glenda = [
        \ '   (\_/) ',
        \ '  =( ^.^)=',
        \ '  /   >🥕 ',
        \ ]

        " Combinamos logo + glenda en las mismas filas
        let l:arte = []
        let l:total_filas = max([len(l:logo), len(l:glenda)])
        for l:i in range(l:total_filas)
            let l:izq = l:i < len(l:logo)   ? l:logo[l:i]   : repeat(' ', 20)
            let l:der = l:i < len(l:glenda) ? l:glenda[l:i] : ''
            call add(l:arte, l:izq . '     ' . l:der)
        endfor

        let l:texto = [
        \ '',
        \ '<-----  A M O R  Y  P A Z  ----->',
        \ '',
        \ '      > i   : empezar a escribir',
        \ '      > :q  : salir de vim',
        \ '      > :wq : guardar y salir',
        \ ]

        let l:contenido = l:arte + l:texto

        " --- CENTRADO DINÁMICO (ancho real, no fijo) ---
        let l:pantalla_alto  = winheight(0)
        let l:pantalla_ancho = winwidth(0)
        let l:anchos = map(copy(l:contenido), 'strwidth(v:val)')
        let l:contenido_ancho = max(l:anchos)
        let l:contenido_alto  = len(l:contenido)

        let l:relleno_v = max([0, (l:pantalla_alto / 2) - (l:contenido_alto / 2)])
        let l:margen_h  = repeat(' ', max([0, (l:pantalla_ancho / 2) - (l:contenido_ancho / 2)]))

        let l:lineas = repeat([''], l:relleno_v)
        for l:linea in l:contenido
            call add(l:lineas, l:margen_h . l:linea)
        endfor

        call setline(1, l:lineas)

        " --- CONFIGURACIÓN DEL BUFFER ---
        setlocal buftype=nofile
        setlocal bufhidden=wipe
        setlocal noswapfile
        setlocal nomodifiable

        " Desaparecer al presionar i
        nnoremap <buffer> <silent> i :enew<Bar>startinsert<CR>
    endif
endfunction
autocmd VimEnter * call StartScreen()
