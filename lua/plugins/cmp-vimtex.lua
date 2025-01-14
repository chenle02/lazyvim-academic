return {

  "micangl/cmp-vimtex",

  config = function()
    require("cmp_vimtex").setup({
      additional_information = {
        info_in_menu = true,
        info_in_window = true,
        info_max_length = 60,
        match_against_info = true,
        origin_in_menu = true,
        symbols_in_menu = true,
        bib_highlighting = true,
        highlight_colors = {
          colon_group = "Normal",
          default_key_group = "PreProc",
          default_value_group = "String",
          important_key_group = "Normal",
          important_value_group = "Identifier",
        },
        highlight_links = {
          Annote = "Default",
          -- Add other groups here if needed.
        },
      },
      bibtex_parser = {
        enabled = true,
      },
      search = {
        browser = "xdg-open",
        default = "google_scholar",
        search_engines = {
          google_scholar = {
            name = "Google Scholar",
            get_url = require("cmp_vimtex").url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
          },
          -- Add other search engines here if needed.
        },
      },
    })
  end,
}
