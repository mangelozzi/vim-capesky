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
                    \[-30,-15,-30],
                    \[-20,-12,-28],
                    \[-15, -5,-25],
                    \[- 8, -8,-15],
                    \[ -5,  0, -8],
                    \[  0,  0,  0],
                    \[+10,+10,+10]]
    endif
    if !exists('g:capesky_index') || force_defaults
        let g:capesky_index = get(g:, 'capesky_index', 4)
        let g:capesky_index = capesky#transform#clamp(
                    \g:capesky_index,
                    \0,
                    \len(g:capesky_profiles) - 1)
    endif

    command! CapeskyPrev  call capesky#applyProfileByIndexDelta(-1)
    command! CapeskyNext  call capesky#applyProfileByIndexDelta(1)
    command! -nargs=* Capesky call capesky#handleCommand(<f-args>)

    nnoremap <silent> <M-1> :CapeskyPrev<CR>
    nnoremap <silent> <M-2> :CapeskyNext<CR>
    let g:capesky_loaded = 1
endfunction

function! s:getcolorstr(ground, color)
    " ground = 'fg' or 'bg'
    " color = 'red' or '#123456' or 123 or ['#123456',123]
    if (tolower(a:ground) == tolower(a:color)) || (tolower(a:color) == 'none')
        " example: ground='fg' or 'bg'
        " Note: This only works for gui not cterm
        return ' gui'.a:ground.'='.a:ground " .' cterm'.a:ground.'='.a:ground
    elseif has_key(g:c, a:color)
        " normal gui index = 0, normal cterm index = 1
        " high_contrast gui index = 2, high_contrast cterm index = 3
        let hex = g:c[a:color][0]
        let cterm = g:c[a:color][1]
        return ' gui'.a:ground.'='.hex.' cterm'.a:ground.'='.cterm
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
        let str .= s:getcolorstr('fg', a:fg)
    endif

    " background
    " a:0 stores the number of optional args passed in
    if a:0 >= 1
        let bg = a:1
        if strlen(bg)
            let str .= s:getcolorstr('bg', bg)
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

function! capesky#alterPalette(contrast, lightness, saturation)
    let old_p = capesky#palette#getPalette()
    let p = {}
    for [name, values] in items(old_p)
        let old_colour = values[0]
        let cterm      = values[1]
        let new_color = capesky#transform#all(old_colour, a:contrast, a:lightness, a:saturation)
        let p[name] = [new_color, cterm]
    endfor
    return p
endfunction

function! capesky#transform#byteclamp(number)
    " floor works better then round for reverse transforms
    let n = (type(a:number) == v:t_float) ? float2nr(round(a:number)) : a:number
    return capesky#transform#clamp(n, 0, 255)
endfunction

function! capesky#transform#lightness(hsl, lightness)
    " lightness from -50 to +50
    let a:hsl.l = capesky#transform#clamp(a:hsl.l + a:lightness/100.0, 0.0, 1.0)
    return a:hsl
endfunction

function! capesky#transform#saturation(hsl, saturation)
    " saturation from -50 to +50
    let foo = a:hsl.s
    let a:hsl.s = capesky#transform#clamp(a:hsl.s + a:saturation/100.0, 0.0, 1.0)
    return a:hsl
endfunction

function! capesky#transform#contrast(rgb, contrast)
    " contrast from -50 to +50
    let f = (80.0 + a:contrast) / (80.0 - a:contrast)
    let x = {}
    let x.r = capesky#transform#byteclamp(f * (a:rgb.r - 128) + 128)
    let x.g = capesky#transform#byteclamp(f * (a:rgb.g - 128) + 128)
    let x.b = capesky#transform#byteclamp(f * (a:rgb.b - 128) + 128)
    return x
endfunction

function! capesky#transform#all(hex, contrast, lightness, saturation)
    " contrast from -50 to +50
    let rgb = capesky#convert#hex2rgb(a:hex)
    let rgb = capesky#transform#contrast(rgb, a:contrast)
    let hsl = capesky#convert#rgb2hsl(rgb)
    let hsl = capesky#transform#lightness(hsl, a:lightness)
    let hsl = capesky#transform#saturation(hsl, a:saturation)
    let rgb = capesky#convert#hsl2rgb(hsl)
    let result = capesky#convert#rgb2hex(rgb)
    return result
endfunction

function! capesky#applyProfile(contrast, lightness, saturation, ...)
    " a:4 = print_idx = optional index
    let profile_str = a:0 > 3 ? " (profile ".a:4.")" : ""
    let contrast   = capesky#transform#clamp(a:contrast,   -50, +50)
    let lightness  = capesky#transform#clamp(a:lightness,  -50, +50)
    let saturation = capesky#transform#clamp(a:saturation, -50, +50)
    let g:c = capesky#alterPalette(contrast, lightness, saturation)
    runtime autoload/capesky/higroups.vim
    redraw
    let settings = printf(' contrast: %3d,  lightness: %3d,  saturation: %3d', contrast, lightness, saturation)
    echom "Capesky".profile_str.settings
endfunction

function! capesky#applyProfileByIndex(index)
    if (a:index < 0) || (a:index > len(g:capesky_profiles) - 1)
        echom "Index out of range."
        return
    endif
    let contrast   = g:capesky_profiles[a:index][0]
    let lightness  = g:capesky_profiles[a:index][1]
    let saturation = g:capesky_profiles[a:index][2]
    call capesky#applyProfile(contrast, lightness, saturation, a:index)
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
    elseif a:0 == 3
        " Contrast Lightness Saturation Passed in
        call capesky#applyProfile(a:1, a:2, a:3)
    else
        echohl error
        echom "Incorrect usage (try with 1 or 3 args): { PROFILE_INDEX | CONTRAST LIGHTNESS SATURATION }"
        echohl None
    endif
endfunction
