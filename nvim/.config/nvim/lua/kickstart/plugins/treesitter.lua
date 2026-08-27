return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    version = '*',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      ignore_install = { 'swift' },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        disable = { 'swift' },
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  vim.treesitter.query.set(
    'markdown',
    'injections',
    [[
  (fenced_code_block
    (info_string
      (language) @injection.language)
    (code_fence_content) @injection.content)

  ((html_block) @injection.content
    (#set! injection.language "html")
    (#set! injection.combined)
    (#set! injection.include-children))

  ((minus_metadata) @injection.content
    (#set! injection.language "yaml")
    (#offset! @injection.content 1 0 -1 0)
    (#set! injection.include-children))

  ((plus_metadata) @injection.content
    (#set! injection.language "toml")
    (#offset! @injection.content 1 0 -1 0)
    (#set! injection.include-children))

  ([
    (inline)
    (pipe_table_cell)
  ] @injection.content
    (#set! injection.language "markdown_inline"))
]]
  ),
}

-- vim: ts=2 sts=2 sw=2 et
