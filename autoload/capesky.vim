let s:term_colors = ['black', 'blue', 'brown', 'cyan', 'darkblue', 'darkcyan', 'darkgray', 'darkgreen', 'darkgrey', 'darkmagenta', 'darkred', 'darkyellow', 'gray', 'green', 'grey', 'lightblue', 'lightcyan', 'lightgray', 'lightgreen', 'lightgrey', 'lightmagenta', 'lightred', 'lightyellow', 'magenta', 'red', 'white', 'yellow']

function! capesky#init(...)
    " Optional arg = force init
    let force_defaults = (a:0 > 0) && (a:1)
    echom force_defaults
    if exists('g:capesky_loaded') && !force_defaults
        return
    endif
    if !exists('g:capesky_profiles') || force_defaults
        " These values range between -50 and 50
        let g:capesky_profiles = [
                    \[  5,  00, -30, -50],
                    \[  5, -15, -20, -30],
                    \[  5, -12, -12, -17],
                    \[  5, -13,  -5, -15],
                    \[  5, -15,  -8,  -8],
                    \[  5,  -8,   0,  -5],
                    \[  0,   0,   0,   0],
                    \[  0, +10, +10, +10],
                    \]
    endif
    if !exists('g:capesky_index') || force_defaults
        let g:capesky_index = get(g:, 'capesky_index', 5)
        let g:capesky_index = capesky#utils#clamp(
                    \g:capesky_index,
                    \0,
                    \len(g:capesky_profiles) - 1)
    endif

    command! CapeskyPrev  call capesky#applyProfileByIndexDelta(-1)
    command! CapeskyNext  call capesky#applyProfileByIndexDelta(1)
    command! -nargs=* Capesky call capesky#handleCommand(<f-args>)

    nnoremap <silent> <M-1> :<C-U>CapeskyPrev<CR>
    nnoremap <silent> <M-2> :<C-U>CapeskyNext<CR>
    let g:capesky_loaded = 1
endfunction

function! s:getColorStr(ground, color)
    " ground = 'fg' or 'bg'
    " color = 'red' or '#123456' or 123 or ['#123456',123]
    if (tolower(a:ground) == tolower(a:color)) || (tolower(a:color) == 'none')
        " example: ground='fg' or 'bg'
        " Note: This only works for gui not cterm
        return ' gui'.a:ground.'='.a:ground " .' cterm'.a:ground.'='.a:ground
    elseif has_key(g:c, a:color)
        let hex   = g:c[a:color][0]
        let xterm = g:c[a:color][1]
        return ' gui'.a:ground.'='.hex.' cterm'.a:ground.'='.xterm
    else
        if type(a:color) == v:t_string
            if a:color[0] == "#"
                " example: a:color='#123456'
                return ' gui'.a:ground.'='.a:color
            else
                if index(s:term_colors, tolower(a:color)) >= 0
                    " example: a:color='red'
                    return ' gui'.a:ground.'='.a:color.' cterm'.a:ground.'='.a:color
                else
                    " example: a:color='fuchsia'
                    " if the string is not a term color, raises an error if
                    " try to set it, e.g. 'fuchsia'
                    return ' gui'.a:ground.'='.a:color
                endif
            endif
        elseif type(a:color) == v:t_number
            " example a:color=123
            return ' gui'.a:ground.'='.a:color
        endif
    endif
endfunction

function! capesky#hi(group, fg, ...)
    let str = 'hi ' . a:group

    " forground
    if strlen(a:fg)
        let str .= s:getColorStr('fg', a:fg)
    endif

    " background
    " a:0 stores the number of optional args passed in
    if a:0 >= 1
        let bg = a:1
        if strlen(bg)
            let str .= s:getColorStr('bg', bg)
        endif
    endif

    " font format
    if a:0 >= 2
        let style = a:2
        if strlen(style)
            let str .= ' gui='.style.' cterm='.style
        endif
    endif
    exe str
endfun

function! capesky#alterPalette(hue, saturation, lightness, contrast)
    let old_p = capesky#palette#getPalette()
    let p = {}
    for [name, old_hex] in items(old_p)
        let hex = capesky#transform#all(old_hex, a:hue, a:saturation, a:lightness, a:contrast)
        let xterm = capesky#utils#hexToXterm(hex)
        let p[name] = [hex, xterm]
    endfor
    return p
endfunction

function! capesky#applyProfile(hue, saturation, lightness, contrast, ...)
    " a:4 = print_idx = optional index
    let profile_str = a:0 > 0 ? " (profile ".a:1.")" : ""
    let hue        = capesky#utils#clamp(a:hue,        -50, +50)
    let saturation = capesky#utils#clamp(a:saturation, -50, +50)
    let lightness  = capesky#utils#clamp(a:lightness,  -50, +50)
    let contrast   = capesky#utils#clamp(a:contrast,   -50, +50)
    let g:c = capesky#alterPalette(hue, saturation, lightness, contrast)
    runtime autoload/capesky/higroups.vim
    redraw
    let settings = printf(' hue %3d,  saturation: %3d,  lightness: %3d,  contrast: %3d', hue, saturation, lightness, contrast)
    echom "Capesky".profile_str.settings
endfunction

function! capesky#applyProfileByIndex(index)
    if (a:index < 0) || (a:index > len(g:capesky_profiles) - 1)
        echom "Index out of range."
        return
    endif
    let hue        = g:capesky_profiles[a:index][0]
    let saturation = g:capesky_profiles[a:index][1]
    let lightness  = g:capesky_profiles[a:index][2]
    let contrast   = g:capesky_profiles[a:index][3]
    call capesky#applyProfile(hue, saturation, lightness, contrast, a:index)
endfunction

function! capesky#applyCurrentProfile()
    call capesky#applyProfileByIndex(g:capesky_index)
endfunction

function! capesky#applyProfileByIndexDelta(delta)
    " delta = change from current profile
    "         -1 = Previous
    "          0 = Current index
    "          1 = Next
    if a:delta != 0
        let old_index = g:capesky_index
        let g:capesky_index += a:delta
        if g:capesky_index < 0
            let g:capesky_index = 0
        elseif g:capesky_index > len(g:capesky_profiles) - 1
            let g:capesky_index = len(g:capesky_profiles) - 1
        endif
        if old_index == g:capesky_index
            echom "Hit end"
            return
        endif
    endif
    call capesky#applyCurrentProfile()
endfunction

function! capesky#handleCommand(...)
    if a:0 == 1
        " Single arg, called as index
        call capesky#applyProfileByIndex(a:1)
    elseif a:0 == 4
        " Hue, Saturation, Lightness, Contrast Passed in
        call capesky#applyProfile(a:1, a:2, a:3, a:4)
    else
        echohl error
        echom "Incorrect usage (try with 1 or 4 args): { PROFILE_INDEX | HUE SATURATION LIGHTNESS CONTRAST }"
        echohl None
    endif
endfunction
