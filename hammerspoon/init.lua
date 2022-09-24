local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

vim:bindHotKeys({ enter = {{'ctrl'}, ';'} })

vim:useFallbackMode('Google Chrome')
vim:disableForApp('iTerm')

vim:enableBetaFeature('block_cursor_overlay')
