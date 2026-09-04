# pyright: reportMissingImports=false

from kitty.fast_data_types import Screen, get_boss, get_options
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb
from kitty.utils import color_as_int

boss = get_boss()
opts = get_options()

def _reset_style(screen: Screen):
    screen.cursor.fg = as_rgb(color_as_int(opts.foreground))
    screen.cursor.bg = as_rgb(color_as_int(opts.tab_bar_background))
    screen.cursor.bold = False
    screen.cursor.italic = False

def _draw_right_status(screen: Screen) -> int:
    mode = boss.mappings.current_keyboard_mode_name or 'normal'
    layout = boss.active_tab.current_layout.name
    cells = [f" m: {mode} ", f" l: {layout} "]

    # NOTE(pencelheimer): total length needed for the right status
    separator = opts.tab_separator
    right_length = sum(len(c) + len(separator) for c in cells)
    draw_spaces = screen.columns - screen.cursor.x - right_length

    # NOTE(pencelheimer): pad with spaces to push content to the right edge
    if draw_spaces > 0:
        _reset_style(screen)
        screen.draw(" " * draw_spaces)

    active_fg = as_rgb(color_as_int(opts.active_tab_foreground))
    active_bg = as_rgb(color_as_int(opts.active_tab_background))

    for cell in cells:
        screen.draw(separator)
        screen.cursor.fg = active_fg
        screen.cursor.bg = active_bg
        screen.draw(cell)
        _reset_style(screen)

    return screen.cursor.x

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    screen.draw(' ')
    draw_title(draw_data, screen, tab, index)

    # NOTE(pencelheimer): truncate if the title is too long
    extra = screen.cursor.x - before - max_title_length
    if extra >= 0:
        screen.cursor.x -= extra + 3
        screen.draw('…')
    screen.draw(' ')

    _reset_style(screen)
    screen.draw(opts.tab_separator)

    # NOTE(pencelheimer): return the actual end of the last tab
    end = screen.cursor.x

    if is_last: _draw_right_status(screen)

    return end
