function! capesky#palette#getPalette()
return {
    \'colorcolumn'      : '#304040',
    \'cursorcolumn'     : '#181818',
    \'cursorline'       : '#550000',
    \'cursorline_insert': '#4F4F4F',
    \'cursorlinenr_bg'  : '#c0c0c0',
    \'cursorlinenr_fg'  : '#303030',
    \'diffadd_bg'       : '#005000',
    \'diffadd_fg'       : '#00CF00',
    \'diffchange_bg'    : '#505000',
    \'diffchange_fg'    : '#FFFF00',
    \'diffdelete_bg'    : '#500000',
    \'diffdelete_fg'    : '#FF0000',
    \'difftext_bg'      : '#500050',
    \'difftext_fg'      : '#FF00FF',
    \'directory'        : '#ffff00',
    \'directory_open'   : '#ffff00',
    \'directory_closed' : '#d0ca50',
    \'directory_empty'  : '#c0c0c0',
    \'directory_root'   : '#00ff00',
    \'endofbuffer'      : '#300000',
    \'foldcolumn_fg'    : '#c000c0',
    \'incsearch'        : '#ffff00',
    \'linenr_bg'        : '#404040',
    \'linenr_fg'        : '#aab0a8',
    \'nontext'          : '#a000a0',
    \'pmenu'            : '#606060',
    \'pmenusbar'        : '#707070',
    \'pmenusel'         : '#00b000',
    \'pmenuthumb'       : '#909090',
    \'search'           : '#ff8300',
    \'signcolumn'       : '#000000',
    \'spellbad'         : '#700000',
    \'spellcap'         : '#600000',
    \'spelllocal'       : '#600000',
    \'spellrare'        : '#600000',
    \'substitute'       : '#ff4434',
    \'tabline_bg'       : '#ababab',
    \'tabline_fg'       : '#000000',
    \'tablinefill'      : '#333333',
    \'tablinesel_bg'    : '#00A000',
    \'tablinesel_fg'    : '#192224',
    \'vertsplit_bg'     : '#a0a0a0',
    \'vertsplit_fg'     : '#808080',
    \'visual'           : '#606060',
    \'whitespace'       : '#a000a0',
    \'wildmenu'         : '#00b000',
    \
    \'main1'            : '#ff4434',
    \'main2'            : '#ff8300',
    \'main3'            : '#ffb300',
    \'main1_bg'         : '#571712',
    \'main2_bg'         : '#633300',
    \'nb1'              : '#ffed00',
    \'nb2'              : '#ffe000',
    \'nb3'              : '#d0d000',
    \'specialh'         : '#9edaff',
    \'special'          : '#7eceff',
    \'speciall'         : '#70b7e3',
    \'special_bg'       : '#2f4d5f',
    \'bushgreen'        : '#c0c000',
    \'stringh'          : '#88ff18',
    \'string'           : '#86e929',
    \'stringl'          : '#71c423',
    \'numberh'          : '#00f000',
    \'number'           : '#00d000',
    \'numberl'          : '#00b000',
    \'constanth'        : '#bdff2d',
    \'constant'         : '#ade929',
    \'constantl'        : '#8aba21',
    \'normalh'          : '#ffefe6',
    \'normal'           : '#ecddd5',
    \'normall'          : '#cabeb7',
    \'normal_bg'        : '#594c46',
    \'noiseh'           : '#f7d6d6',
    \'noise'            : '#dbbdbd',
    \'noisel'           : '#c1a7a7',
    \'noisell'          : '#a69090',
    \'commenth'         : '#dadada',
    \'comment'          : '#c0c0c0',
    \'commentl'         : '#a0a0a0',
    \'alth'             : '#e2cffd',
    \'alt'              : '#bdb3ce',
    \'altl'             : '#ada4bc',
    \'alt_bg'           : '#4e4a55',
    \'brownh'           : '#f5af8a',
    \'brown'            : '#d09576',
    \'brownl'           : '#b07e63',
    \'pinkh'            : '#ff6b8a',
    \'pink'             : '#ff90a7',
    \'pinkl'            : '#e17f93',
    \'purpleh'          : '#ff82dc',
    \'purple'           : '#ffa5e6',
    \'purplel'          : '#e392cc',
    \'purple_bg'        : '#634059',
    \'oldlime'          : '#8aba21',
    \'oldneonlime'      : '#888888',
    \'oldmustard'       : '#888888',
    \'oldstone'         : '#888888',
    \'oldskygray'       : '#888888',
    \'oldskybright'     : '#888888',
    \'oldskypale'       : '#888888',
    \'oldgray'          : '#888888',
    \'oldindigo'        : '#888888',
    \'oldbluegray'      : '#888888',
    \'oldpurple'        : '#888888',
    \'oldpeach'         : '#888888',
    \'isoerrorred'      : '#ff4434',
    \'isowarningorange' : '#ff8300',
    \'isocautionyellow' : '#ffed00',
    \'bg'               : '#000000',
    \'bgh'              : '#404040',
    \'bghh'             : '#606060',
    \'class_bg'         : '#504000',
    \
    \'statusline_fg'    : '#202020',
    \'statusline_bg'    : '#00A000',
    \'_statusfade1_fg'  : '#00AD00',
    \'_statusfade1_bg'  : '#00BB00',
    \'_statusfade2_fg'  : '#00C800',
    \'_statusfade2_bg'  : '#00D600',
    \'_statusfade3_fg'  : '#00E300',
    \'_statusfade3_bg'  : '#00F100',
    \'_statusfile_fg'   : '#000000',
    \'_statusfile_bg'   : '#00FF00',
    \'_statussubtle_fg' : '#005500',
    \'_statusimpact_fg' : '#ffb000',
    \'_statussubtle_bg' : '#00A000',
    \
    \'statuslinenc_fg'      : '#000000',
    \'statuslinenc_bg'      : '#a0a0a0',
    \'_statusfadenc1_fg'    : '#b0b0b0',
    \'_statusfadenc1_bg'    : '#b0b0b0',
    \'_statusfadenc2_fg'    : '#b8b8b8',
    \'_statusfadenc2_bg'    : '#b8b8b8',
    \'_statusfadenc3_fg'    : '#c0c0c0',
    \'_statusfadenc3_bg'    : '#c8c8c8',
    \'_statusfilenc_fg'     : '#000000',
    \'_statusfilenc_bg'     : '#d0d0d0',
    \'_statussubtlenc_fg'   : '#707070',
    \'_statussubtlenc_bg'   : '#a0a0a0',
    \
    \'_qfstatusline_bg'     : '#c0c000',
    \'_qfstatusline_fg'     : '#000000',
    \'_qfstatusfade1_fg'    : '#c8c800',
    \'_qfstatusfade1_bg'    : '#d0d000',
    \'_qfstatusfade2_fg'    : '#d8d800',
    \'_qfstatusfade2_bg'    : '#e0e000',
    \'_qfstatusfade3_fg'    : '#e8e800',
    \'_qfstatusfade3_bg'    : '#f0f000',
    \'_qfstatusfile_fg'     : '#000000',
    \'_qfstatusfile_bg'     : '#ffff00',
    \'_qfstatuslinenc_fg'   : '#ffff00',
    \'_qfstatuslinenc_bg'   : '#777700',
    \'_qfstatussubtle_fg'   : '#909000',
    \'_qfstatussubtle_bg'   : '#c0c000',
    \
    \'_helpstatusline_fg'   : '#000000',
    \'_helpstatusline_bg'   : '#a000e0',
    \'_helpstatusfade1_fg'  : '#a800e4',
    \'_helpstatusfade1_bg'  : '#b000e8',
    \'_helpstatusfade2_fg'  : '#b800ea',
    \'_helpstatusfade2_bg'  : '#c000f0',
    \'_helpstatusfade3_fg'  : '#d000f4',
    \'_helpstatusfade3_bg'  : '#e000f8',
    \'_helpstatusfile_fg'   : '#000000',
    \'_helpstatusfile_bg'   : '#ff00ff',
    \'_helpstatuslinenc_fg' : '#ff00ff',
    \'_helpstatuslinenc_bg' : '#770077',
    \'_helpstatussublte_fg' : '#000077',
    \'_helpstatussublte_bg' : '#a000e0',
    \}
endfunction
