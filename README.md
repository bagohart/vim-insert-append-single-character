
# Vim-Insert-Single-Character
This Vim plugin provides actions for inserting a single character without entering insert mode.

# Why?
Vim has the `r` action to replace a single character without entering Replace mode.\
Why is there no action to insert/append a single character? Now there is. You can:
* In normal mode:
    * Insert/Append a single character at the cursor
    * Insert/Append a single character at the beginning/end of the line
* In insert mode:
    * Insert/Append a single character at the beginning/end of the line

# Guide
## Mappings
No mappings are created automatically. Add your own. I use:
```
nmap <Leader>i <Plug>(ISC-insert-at-cursor)
nmap <Leader>I <Plug>(ISC-insert-at-start)
nmap <Leader>a <Plug>(ISC-append-at-cursor)
nmap <Leader>A <Plug>(ISC-append-at-end)
nmap <Leader>i<CR> <Plug>(ISC-insert-enter-at-cursor)
nmap <Leader>a<CR> <Plug>(ISC-append-enter-at-cursor)
imap <M-i> <Plug>(ISC-insert-at-start-insert-mode)
imap <M-a> <Plug>(ISC-append-at-end-insert-mode)
```

## Usage
In normal mode, type `[count]<Leader>i{char}` to insert `{char}` before the cursor `[count]` times.\
Type `[count]<Leader>a{char}` to append `{char}` `[count]` times after the cursor.\
Type `[count]<Leader>I{char}` to insert `{char}` `[count]` times at the beginning of the line. (Like `I` does).\
Type `[count]<Leader>A{char}` to append `{char}` `[count]` times at the end of the line. (Like `A` does).

In insert mode, type `<M-i>{char}` to insert a single `{char}` at the beginning of the line.\
Type `<M-a>{char}` to append a single `{char}` at the end of the line.

The insertion of a newline at the cursor is treated as a special case, and therefore gets its own `<Plug>` object.
If you don't like the way this plugin handles this, simply define your own mappings for `<Leader>i<CR>` and `<Leader>a<CR>`.

The insertion of a newline at the beginning/end of the line is not supported in order not to reinvent the wheel.\
You could use the corresponding functionality of [vim-unimpaired](https://github.com/tpope/vim-unimpaired) and add the following mappings though:
```
nmap <Leader>I<CR> [<Space>
nmap <Leader>A<CR> ]<Space>
```
But I find it more practical to use `[<Space>` and `]<Space>` directly.

Note that this plugin uses insert mode under the hood, so `<C-a>` in insert mode inserts what you have entered using any of the `<Plug>` mappings above.

All normal-mode mappings are dot-repeatable, without dependency on [vim-repeat](https://github.com/tpope/vim-repeat).

## Mappings for predefined characters
You could use the existing plugs to build more specific mappings on top of them.
For example, this mapping would let you append a `;` at the end of the line without moving the cursor:
```
nmap <Leader>; <Plug>(ISC-append-at-end);
```

## Settings
### `g:InsertSingleCharacter_show_prompt_message`
**default: `1`**

If enabled, a prompt will be shown indicating that the user should input a single character.

### `g:InsertSingleCharacter_keep_cursor_position`
**default: `1`**

If enabled, the cursor does not move when inserting/appending a single character at the cursor position.
Does not apply to the remaining actions, where the cursor never moves.

### `g:InsertSingleCharacter_reuse_first_count_on_repeat`
**default: `1`**

If enabled, `.` adds the same string as the last invocation.\
If disabled, `.` adds the same character, but only once.\
The count can always be explicitly overwritten on the next invocation of `.`.

# Requirements
Developed and tested on Neovim 0.4.3. When I tested it on Vim 8.2, it worked, too.

# Bugs
* In some edge cases, the `'[` and `']` marks may not be set correctly. This will be easy to fix once extended marks are built into Vim, but that will have Neovim support only. In Vim the same could be probably be done via text properties.

Other than that, I've been using this for years without problems.

# Credits / Related Plugins
I didn't come up with this idea, it [has](https://superuser.com/questions/581572/insert-single-character-in-vim) [been](https://vi.stackexchange.com/questions/5176/is-there-a-way-to-insert-a-single-character-and-then-exit-insert-mode) [there](https://stackoverflow.com/questions/21197820/insert-character-without-entering-insert-mode) [for](https://vim.fandom.com/wiki/Insert_a_single_character) [a long time](https://github.com/rjayatilleka/vim-insert-char).
But to my knowledge, until now this concept has never been packaged into a comprehensive plugin that supports counts, repeating with dot, and gets all the edge cases right.

If you don't like this plugin's behaviour with respect to inserting newlines, try this:
* [vim-split-line](https://github.com/drzel/vim-split-line) Dedicated plugin for splitting lines that you may prefer to using `<Leader>i<CR>`

# License
The Vim licence applies. See `:help license`.
