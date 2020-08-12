# vim-capesky
Color theme for Projectors (has variable light levels) based on a Cape Town sunset.
One can tweak with theme with custom contrast/lightness/saturation settings, and then save them in an array in you `$MYVIMRC` file. Then as the lighting conditions changes, one can quickly jump between the colour profiles.

The follow two hotkeys and commands are included in the theme, and are only available if the theme has been applied.

## (Optional) Requirements

- [vim-javascript](https://github.com/pangloss/vim-javascript) profiles vastly superior js highlighting. Recommended but necessary.

## Commands

`:CapeskyPrev` - Selects the previous profile

`:CapeskyNext` - Selects the next profile

`:Capesky <profile_index>` - Selects the profile with the given index (`0` based cause we are programmers)

`:Capesky <contrast> <lightness> <saturation>` - Set theme with the given color settings.
Each settings is between `-50` and `+50`.

## Hotkeys
These are defined once the the theme has been applied.  
`nnoremap <silent> <M-1> :CapeskyPrev<CR>` - Press ALT+1 to goto the previous profile.

`nnoremap <silent> <M-2> :CapeskyNext<CR>` - Press ALT+2 to goto the next profile.

## Default profiles
The profiles are stored in a 2D array as follows:
```
[
    [contrast0, lightness0, saturation0],  # Profile 0
    [contrast1, lightness1, saturation1],  # Profile 1
    [contrast2, lightness2, saturation2],  # Profile 2
    ...
]
```

Default settings (vim script), these can be altered and placed in your `$MYVIMRC` file to adjust the defaults
```viml
let g:capesky_profiles = [
            \[-30, -15, -30],
            \[-20, -12, -28],
            \[-15,  -5, -25],
            \[- 8,  -8, -15],
            \[ -5,   0,  -8],
            \[  0,   0,   0],
            \[+10, +10, +10]]
```
## Default profile index
When Neovim/Vim starts up, it specifies which index to use by default. The default is `4`. You can override it with:
```
let g:capesky_index = get(g:, 'capesky_index', 4)
```
