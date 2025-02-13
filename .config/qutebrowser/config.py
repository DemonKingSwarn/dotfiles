import dracula.draw

config.load_autoconfig(True)
c.completion.cmd_history_max_items = 0
c.completion.shrink = True
c.completion.timestamp_format = '%H:%M %d.%m.'
c.completion.web_history.max_items = 500
c.confirm_quit = ['downloads']
c.content.canvas_reading = False
#c.content.cookies.accept = 'all' #teams and zoom need 3rdparty cookies
c.content.cookies.accept = 'no-3rdparty' #teams need 3rdparty cookies
c.content.cookies.store = True
c.content.fullscreen.overlay_timeout = 0
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'
c.downloads.location.prompt = False
c.downloads.remove_finished = 1000
c.input.forward_unbound_keys = 'none'
c.keyhint.delay = 0
c.new_instance_open_target = 'tab-bg-silent'
c.scrolling.bar = 'never'
c.statusbar.widgets = ['keypress', 'scroll', 'progress']
c.tabs.last_close = 'default-page'
c.zoom.default = "100%"
c.downloads.location.directory = "~/dl"

#searx
c.url.default_page = 'https://demonkingswarn.is-a.dev/startpage'
c.url.start_pages = 'https://search.demonkingswarn.live/'
c.url.searchengines = {'DEFAULT':'https://search.demonkingswarn.live/?q={}'}

#fonts
c.fonts.default_family = "JetBrains Mono"
c.fonts.default_size = "12pt"
c.fonts.contextmenu = 'default_size default_family'
c.fonts.prompts = 'default_size default_family'

config.bind(',dr', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized/darculized-all-sites.css ""')
config.set("colors.webpage.darkmode.enabled", True)

dracula.draw.blood(c,{
    'spacing':{
        'vertical':6,
        'horizontal':8
    }
})
