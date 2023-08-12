# qutebrowser config
config.load_autoconfig(False)

# dark mode
#config.set("colors.webpage.darkmode.enabled", True)

# cookies
#config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# open with mpv
config.bind('wv', 'spawn -d mpv {url}', mode='normal')

# default search engine
c.url.searchengines = {'DEFAULT': 'https://www.startpage.com/sp/search/?q={}',
        'search-google': 'https://www.google.com/search?q={}',
        'search-youtube': 'https://www.youtube.com/results?search_query={}',
        'search-github': 'https://github.com/search?q={}',
        'search-amazon': 'https://www.amazon.com/s?k={}'}

# default download dir
c.downloads.location.directory = '~/dl'

# default start page
c.url.start_pages = '~/.config/qutebrowser/startpage/index.html'

# open startpage
config.bind('sp', ':home')

# tab prev and next
config.bind('J', ':tab-prev')
config.bind('K', ':tab-next')
config.bind(',Y', 'hint links spawn mpv {hint-url}')
config.bind(',b', 'config-cycle statusbar.show always never')
config.bind(',t', 'config-cycle tabs.show always never')
config.bind(',x', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind(',ss', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css_color/solarized-dark-all-sites.css ""')
config.bind(',sd', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css_color/darculized-all-sites.css ""')


# command font
c.fonts.default_size = '12pt'
c.fonts.completion.entry = '12pt "monospace"'
c.fonts.debug_console = '12pt "monospace"'
c.fonts.prompts = '12pt monospace'
c.fonts.statusbar = '12pt "monospace"'

'''
# youtube ad-blocking
from qutebrowser.api import interceptor
import subprocess
def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
            url.host() == "www.youtube.com"
            and url.path() == "/get_video_info"
            and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)
'''
