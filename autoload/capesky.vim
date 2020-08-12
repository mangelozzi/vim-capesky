let s:term_colors = ['black', 'blue', 'brown', 'cyan', 'darkblue', 'darkcyan', 'darkgray', 'darkgreen', 'darkgrey', 'darkmagenta', 'darkred', 'darkyellow', 'gray', 'green', 'grey', 'lightblue', 'lightcyan', 'lightgray', 'lightgreen', 'lightgrey', 'lightmagenta', 'lightred', 'lightyellow', 'magenta', 'red', 'white', 'yellow']
let g:c = capesky#palette#getPalette()


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
        let hexc = g:c[a:color][0]
        let cterm = g:c[a:color][1]
        let hexc = capesky#transform#all(hexc, g:capesky_contrast, g:capesky_lightness, g:capesky_saturation)
        return ' gui'.a:ground.'='.hexc.' cterm'.a:ground.'='.cterm
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

function! capesky#setColors(contrast, lightness, saturation)
    let g:capesky_contrast   = capesky#transform#clamp(a:contrast,   -50, +50)
    let g:capesky_lightness  = capesky#transform#clamp(a:lightness,  -50, +50)
    let g:capesky_saturation = capesky#transform#clamp(a:saturation, -50, +50)
    color capesky
endfunction

function! capesky#changeindex(delta)
    let old_index = g:capesky_index
    let g:capesky_index += a:delta
    if g:capesky_index < 0
        let g:capesky_index = 0
    elseif g:capesky_index > len(g:capesky_set) - 1
        let g:capesky_index = len(g:capesky_set) - 1
    endif
    if old_index == g:capesky_index
        echom "Hit end"
        return
    endif
    let contrast   = g:capesky_set[g:capesky_index][0]
    let lightness  = g:capesky_set[g:capesky_index][1]
    let saturation = g:capesky_set[g:capesky_index][2]
    call capesky#setColors(contrast, lightness, saturation)
endfunction

function! capesky#init()
    let g:capesky_index = get(g:, 'capesky_index', 2)
    if !exists('g:capesky_set')
        " These values range between -50 and 50
        let g:capesky_set = [[-30,-15,-30], [-20,-12,-20], [-15,-10,-20], [-08,-08,-15], [0,0,0], [10,10,10]]
    endif
    let g:capesky_contrast   = g:capesky_set[g:capesky_index][0]
    let g:capesky_lightness  = g:capesky_set[g:capesky_index][1]
    let g:capesky_saturation = g:capesky_set[g:capesky_index][2]
endfunction
