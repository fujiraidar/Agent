module MarkdownHelper
  require "redcarpet"
    require "coderay"

    class HTMLwithCoderay < Redcarpet::Render::HTML
        def block_code(code, language)
            language = language.split(':')[0]

            case language.to_s
            when 'rb'
                lang = 'ruby'
            when 'yml'
                lang = 'yaml'
            when 'css'
                lang = 'css'
            when 'html'
                lang = 'html'
            when ''
                lang = 'md'
            else
                lang = language
            end

            CodeRay.scan(code, lang).div
        end
    end

    def markdown(text)
        html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
        options = {
            autolink: true,
            space_after_headers: true,
            no_intra_emphasis: true,
            fenced_code_blocks: true,
            tables: true,
            hard_wrap: true,
            xhtml: true,
            lax_html_blocks: true,
            strikethrough: true
        }
        extensions = {
	        autolink:           true,
	        no_intra_emphasis:  true,
	        fenced_code_blocks: true,
	        tables:             true
	    }
        markdown = Redcarpet::Markdown.new(html_render, options)
        markdown.render(text).html_safe
    end

    def toc(text)
	    toc_option = {
	      nesting_level: 2
	    }

	    toc_renderer = Redcarpet::Render::HTML_TOC.new
	    toc = Redcarpet::Markdown.new(toc_renderer, toc_option)
	    toc.render(text).html_safe
	end
end