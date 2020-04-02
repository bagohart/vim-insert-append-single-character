" Reload guard {{{
if &compatible || exists("g:loaded_insert_single_character")
    finish
endif
let g:loaded_insert_single_character = 1
" }}}

" force reload autoloading hack {{{
" call insert_single_character#Baaad()
" }}}

" Settings {{{
let g:InsertSingleCharacter_show_prompt_message = get(g:, "InsertSingleCharacter_show_prompt_message", 1)
let g:InsertSingleCharacter_keep_cursor_position = get(g:, "InsertSingleCharacter_keep_cursor_position", 1)
let g:InsertSingleCharacter_reuse_first_count_on_repeat = get(g:, "InsertSingleCharacter_reuse_first_count_on_repeat", 1)
" }}}

" Plug mappings {{{
nnoremap <silent> <Plug>(ISC-insert-at-cursor) :<C-u>call insert_single_character#InsertAtCursor()<CR>
nnoremap <silent> <Plug>(ISC-insert-at-cursor-repeat) :<C-u>call insert_single_character#InsertAtCursorRepeat()<CR>

nnoremap <silent> <Plug>(ISC-append-at-cursor) :<C-u>call insert_single_character#AppendAtCursor()<CR>
nnoremap <silent> <Plug>(ISC-append-at-cursor-repeat) :<C-u>call insert_single_character#AppendAtCursorRepeat()<CR>

nnoremap <silent> <Plug>(ISC-insert-at-start) :<C-u>call insert_single_character#InsertAtStart()<CR>
nnoremap <silent> <Plug>(ISC-insert-at-start-repeat) :<C-u>call insert_single_character#InsertAtStartRepeat()<CR>

nnoremap <silent> <Plug>(ISC-append-at-end) :<C-u>call insert_single_character#AppendAtEnd()<CR>
nnoremap <silent> <Plug>(ISC-append-at-end-repeat) :<C-u>call insert_single_character#AppendAtEndRepeat()<CR>

inoremap <silent> <Plug>(ISC-insert-at-start-insert-mode) <Esc>:<C-u>call insert_single_character#InsertAtStartInsertMode()<CR>
inoremap <silent> <Plug>(ISC-append-at-end-insert-mode) <Esc>:<C-u>call insert_single_character#AppendAtEndInsertMode()<CR>

nnoremap <silent> <Plug>(ISC-insert-enter-at-cursor) :<C-u>call insert_single_character#InsertEnterAtCursor()<CR>
nnoremap <silent> <Plug>(ISC-append-enter-at-cursor) :<C-u>call insert_single_character#AppendEnterAtCursor()<CR>
" }}}

" usermappings {{{
" nmap <Leader>i <Plug>(ISC-insert-at-cursor)
" nmap <Leader>I <Plug>(ISC-insert-at-start)
" nmap <Leader>a <Plug>(ISC-append-at-cursor)
" nmap <Leader>A <Plug>(ISC-append-at-end)
" imap <M-i> <Plug>(ISC-insert-at-start-insert-mode)
" imap <M-a> <Plug>(ISC-append-at-end-insert-mode)
" nmap <Leader>i<CR> <Plug>(ISC-insert-enter-at-cursor)
" nmap <Leader>a<CR> <Plug>(ISC-append-enter-at-cursor)
" }}}


