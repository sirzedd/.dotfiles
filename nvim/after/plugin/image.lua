--local clip_img = require('clipboard-image')
--local clip_img = require('clipboard-image')
--clip_img.setup({img_dir = 'assets'})
--clip_img.setup({img_dir = 'assets'})

require('img-clip').setup({
    default = {
      dir_path = "attachment-images",
      relative_to_current_file = false,
      insert_mode_after_paste = false,
    }
})
