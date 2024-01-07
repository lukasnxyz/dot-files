/*      _
 *   __| |_      ___ __ ___
 *  / _` \ \ /\ / / '_ ` _ \
 * | (_| |\ V  V /| | | | | |
 *  \__,_| \_/\_/ |_| |_| |_|
*/
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx       = 1;   /* border pixel of windows */
static const unsigned int snap           = 10;  /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray             = 1;   /* 0 means no systray */
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */
static const char *fonts[]               = { "iosevka:size=14"};
static const char dmenufont[]            = "iosevka:size=14";
static const char col_gray1[]            = "#222222"; // #222222
static const char col_gray2[]            = "#444444"; // #444444
static const char col_gray3[]            = "#bbbbbb"; // #bbbbbb
static const char col_gray4[]            = "#eeeeee"; // #eeeeee
static const char col_main[]             = "#005577"; // #005577
static const char *colors[][3]           = {
    /*               fg         bg         border   */
    [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
    [SchemeSel]  = { col_gray4, col_main,  col_main  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class        instance    title       tags mask     isfloating   monitor */
	{ "XCalc",         NULL,    NULL,              0,             1,       -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },    /* first entry is default */
    { "[M]",      monocle },    /* stack layout */
    { "<><",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0";
static const char *cmddmenu[] = { "dmenu_run", "-i", "-p", "run", NULL };
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_main, "-sf", col_gray4, "-p", "run:", NULL };
static const char *cmdscreenshot[]  = { "scrot", "-s", "-e", "mv $f ~/media/scrots", NULL };
static const char *cmdsoundup[]  = { "amixer", "-q", "sset", "Master", "5%+", NULL };
static const char *cmdsounddown[]  = { "amixer", "-q", "sset", "Master", "5%-", NULL };
static const char *cmdsoundtoggle[]  = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *cmdcapturetoggle[]  = { "amixer", "-q", "sset", "Capture", "toggle", NULL };

static Key keys[] = {
    /* modifier                     key        function        argument */

    /* applications */
    { MODKEY,                       XK_p,      spawn,          {.v = cmddmenu } },
    { 0,                   XF86XK_Search,      spawn,          {.v = cmddmenu } },
    { MODKEY,                  XK_Return,      spawn,          SHCMD("$TERMINAL") },
    { MODKEY,                       XK_w,      spawn,          SHCMD("$BROWSER") },
    { MODKEY,                       XK_a,      spawn,          SHCMD("$TERMINAL -e pulsemixer") },
    { MODKEY,                       XK_f,      spawn,          SHCMD("$TERMINAL -e vifmrun") },
    { MODKEY,                       XK_r,      spawn,          SHCMD("dmenu_redshift.sh") },
    { MODKEY,                       XK_s,      spawn,          {.v = cmdscreenshot } },
    { MODKEY,                       XK_c,      spawn,          SHCMD("xcalc") },
    { MODKEY,                   XK_grave,      spawn,          SHCMD("clipmenu -p clipboard") },
    { MODKEY,                       XK_v,      spawn,          SHCMD("dmenu_accent_letters.sh") },
    { MODKEY|ShiftMask,             XK_k,      spawn,          SHCMD("xset r rate 300 50") },
    { MODKEY|ShiftMask,             XK_m,      spawn,          SHCMD("autorandr --change") },
    { MODKEY|ShiftMask,             XK_s,      spawn,          SHCMD("systemctl suspend") },

    /* media keys */
    { 0,         XF86XK_AudioRaiseVolume,      spawn,          {.v = cmdsoundup } },
    { 0,         XF86XK_AudioLowerVolume,      spawn,          {.v = cmdsounddown } },
    { 0,                XF86XK_AudioMute,      spawn,          {.v = cmdsoundtoggle } },
    { MODKEY,                      XK_F9,      spawn,          {.v = cmdcapturetoggle } },
    { 0,                XF86XK_AudioNext,      spawn,          SHCMD("playerctl next") },
    { 0,                XF86XK_AudioPlay,      spawn,          SHCMD("playerctl play-pause") },
    { 0,                XF86XK_AudioPrev,      spawn,          SHCMD("playerctl previous") },
    { 0,          XF86XK_MonBrightnessUp,      spawn,          SHCMD("xbacklight -inc 5") },
    { 0,             XF86XK_AudioMicMute,      spawn,          {.v = cmdcapturetoggle } },
    { 0,        XF86XK_MonBrightnessDown,      spawn,          SHCMD("xbacklight -dec 5") },

    /* dwm keys */
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY|ShiftMask,         XK_equal,      incnmaster,     {.i = +1 } },
    { MODKEY|ShiftMask,         XK_minus,      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.01 } },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.01 } },
    { MODKEY,               XK_backslash,      setmfact,       {.f = 1.55 } },
    { MODKEY|ShiftMask,     XK_backslash,      setmfact,       {.f = 1.50 } },
    { MODKEY|ShiftMask,        XK_Return,      zoom,           {0} },
    { MODKEY,                     XK_Tab,      view,           {0} },
    { MODKEY,                       XK_q,      killclient,     {0} },
    { MODKEY|ShiftMask,         XK_space,      setlayout,      {0} },
    { MODKEY,                   XK_space,      togglefloating, {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    { MODKEY|ShiftMask,     XK_BackSpace,      quit,           {0} },

    /* navigation with multiple monitors */
    { MODKEY,               XK_semicolon,      focusmon,       {.i = -1 } },
    { MODKEY,              XK_apostrophe,      focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,     XK_semicolon,      tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,    XK_apostrophe,      tagmon,         {.i = +1 } },

    /* layouts */
    { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_n,      setlayout,      {.v = &layouts[2]} },

    /* tags */
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          SHCMD("$TERMINAL") },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
