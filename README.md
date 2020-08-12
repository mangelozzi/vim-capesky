# vim-capesky

Color theme for Projectors (has variable light levels) based on a Cape Town sunset.
One can tweak with theme with custom hue/saturation/lightness/contrast settings, and then save them in an array in you `$MYVIMRC` file. Then as the lighting conditions changes, one can quickly jump between the colour profiles.

The follow two hotkeys and commands are included in the theme, and are only available if the theme has been applied.

## TODO

- term color support

## (Optional) Requirements

- [vim-javascript](https://github.com/pangloss/vim-javascript) profiles vastly superior js highlighting. Recommended but necessary.

## Commands

`:CapeskyPrev` - Selects the previous profile

`:CapeskyNext` - Selects the next profile

`:Capesky <profile_index>` - Selects the profile with the given index (`0` based cause we are programmers)

`:Capesky <hue> <saturation> <lightness> <contrast>` - Set theme with the given color settings.
Each settings is between `-50` and `+50`.

## Hotkeys

These are defined once the the theme has been applied.  
`nnoremap <silent> <M-1> :CapeskyPrev<CR>` - Press ALT+1 to goto the previous profile.

`nnoremap <silent> <M-2> :CapeskyNext<CR>` - Press ALT+2 to goto the next profile.

## Default profiles

The profiles are stored in a 2D array as follows:
```
[
    [hue0, saturation0, lightness0, contrast0],  # Profile 0
    [hue1, saturation1, lightness1, contrast1],  # Profile 1
    [hue2, saturation2, lightness2, contrast2],  # Profile 2
    ...
]
```

Default settings (vim script), these can be altered and placed in your `$MYVIMRC` file to adjust the defaults
```vim
        let g:capesky_profiles = [
                    \[ 50, -30, -15, -30],
                    \[ 40, -28, -12, -20],
                    \[ 30, -25,  -5, -15],
                    \[ 20, -15,  -8,  -8],
                    \[ 10,  -8,   0,  -5],
                    \[  0,   0,   0,   0],
                    \[ 10, +10, +10, +10],
                    \]
```

## Default profile index

When Neovim/Vim starts up, it specifies which index to use by default. The default is `4`. You can override it with:

```vim
let g:capesky_index = get(g:, 'capesky_index', 4)
```
