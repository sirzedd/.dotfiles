" Good example https://github.com/chrisgrieser/.config/blob/main/obsidian/obsidian.vimrc
"
set clipboard=unnamed

unmap <Space>

" I like using H and L for beginning/end of line
nmap H ^
nmap L $
" Go up and down by bracket, homerow that
nmap J %
nmap K %

exmap back obcommand app:go-back
nmap gb :back

exmap forward obcommand app:go-forward
nmap gf :forward

exmap focusLeft obcommand editor:focus-left
nmap <C-h> :focusLeft

exmap focusRight obcommand editor:focus-right
nmap <C-l> :focusRight

exmap focusTop obcommand editor:focus-top
nmap <C-k> :focusTop

exmap focusDown obcommand editor:focus-bottom
nmap <C-j> :focusDown


exmap splitVertical obcommand workspace:split-vertical
nmap <Space>v :splitVertical

exmap splitHorizontal obcommand workspace:split-horizontal
nmap <Space>h :splitHorizontal

imap kj <Esc>
imap KJ <Esc>


" <Esc> clears notices & highlights (:nohl)
exmap clearNotices obcommand obsidian-smarter-md-hotkeys:hide-notice
nmap &c& :clearNotices
nmap &n& :nohl
nmap <Esc> &c&&n&

" sentence navigation
nmap [ (
nmap ] )

" next diagnostic
exmap nextSuggestion obcommand obsidian-languagetool-plugin:ltjump-to-next-suggestion
nmap ge :nextSuggestion

" [g]oto [s]ymbol
" requires Another Quick Switcher Plugin
exmap gotoHeading obcommand obsidian-another-quick-switcher:header-floating-search-in-file
nmap gs :gotoHeading

" [g]oto definition / link (shukuchi makes it forward-seeking)
exmap followNextLink obcommand shukuchi:open-link
nmap gx :followNextLink
nmap ga :followNextLink
nmap gd :followNextLink

" [g]oto [o]pen file (= Quick Switcher)
exmap quickSwitcher obcommand obsidian-another-quick-switcher:search-command_recent-search
nmap go :quickSwitcher
nmap gr :quickSwitcher


" go to last change (HACK, only works to jump to the last location)
nmap gc u<C-r>
