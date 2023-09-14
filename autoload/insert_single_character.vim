" Fast Insert/Append at cursor {{{
function! insert_single_character#InsertAtCursorDotRepeat()
    function! s:inner(...) closure abort
        let new_string = s:GetInputString("insert at cursor")
        if s:last_inserted_char !=# "\<CR>"
            call s:InsertStringAtCursor(new_string)
            let &opfunc=get(funcref('s:inner_repeat'), 'name')
        endif
    endfunction
    function! s:inner_repeat(...) closure abort
        let new_string = s:GetRepeatString(v:count)
        call s:InsertStringAtCursor(new_string)
    endfunction
    let &opfunc=get(funcref('s:inner'), 'name')
    return 'g@l'
endfunction

function! insert_single_character#InsertAtCursor()
    let new_string = s:GetInputString("insert at cursor")
    if s:last_inserted_char !=# "\<CR>"
        call s:InsertStringAtCursor(new_string)
        call repeat#set("\<Plug>(ISC-insert-at-cursor-repeat)")
    endif
endfunction

" new_string must be n identical characters
function! s:InsertStringAtCursor(new_string)
    execute "keepjumps normal! i" . a:new_string . "\<Esc>"
    " todo: remove this corner case handling with extended marks once available
    if g:InsertSingleCharacter_keep_cursor_position
        normal! l
    endif
endfunction

function! insert_single_character#InsertAtCursorRepeat()
    " echom "Called insert_single_character#InsertAtCursorRepeat() with v:count=" . v:count
    let new_string = s:GetRepeatString(v:count)
    call s:InsertStringAtCursor(new_string)
    call repeat#set("\<Plug>(ISC-insert-at-cursor-repeat)")
endfunction

function! s:GetInputString(prompt)
    let s:last_count = v:count1
    if g:InsertSingleCharacter_show_prompt_message
        if v:count1 ==# 1
            echo "Enter single character to " . a:prompt "..."
        else
            echo "Enter single character to " . a:prompt . " " . v:count1 . " times..."
        endif
    endif
    let s:last_inserted_char = nr2char(getchar())
    return repeat(s:last_inserted_char, v:count1)
endfunction

function! s:GetRepeatString(times)
    if a:times ==# 0
        return g:InsertSingleCharacter_reuse_first_count_on_repeat ?  
                    \ repeat(s:last_inserted_char, s:last_count) :
                    \ s:last_inserted_char
    else
        let s:last_count = a:times
        return repeat(s:last_inserted_char, a:times)
    endif
endfunction

function! insert_single_character#AppendAtCursorDotRepeat()
    function! s:inner(...) closure abort
        let new_string = s:GetInputString("append at cursor")
        if s:last_inserted_char !=# "\<CR>"
            call s:AppendStringAtCursor(new_string)
            let &opfunc=get(funcref('s:inner_repeat'), 'name')
        endif
    endfunction
    function! s:inner_repeat(...) closure abort
        let new_string = s:GetRepeatString(v:count)
        call s:AppendStringAtCursor(new_string)
    endfunction
    let &opfunc=get(funcref('s:inner'), 'name')
    return 'g@l'
endfunction

function! insert_single_character#AppendAtCursor()
    let new_string = s:GetInputString("append at cursor")
    if s:last_inserted_char !=# "\<CR>"
        call s:AppendStringAtCursor(new_string)
        call repeat#set("\<Plug>(ISC-append-at-cursor-repeat)")
    endif
endfunction

function! s:AppendStringAtCursor(new_string)
    execute "keepjumps normal! a" . a:new_string . "\<Esc>"
    if g:InsertSingleCharacter_keep_cursor_position
        let l = len(a:new_string)
        for i in range(l)
            normal! h
        endfor 
        " I can't do the following 
        "     'normal! ' . len(a:new_string) . 'h'
        "     execute 'normal! ' . len(a:new_string) . 'h'
        " because that messes up the count for the repeat!
        " See :help .
        " Not really sure why this happens.
    endif
endfunction

function! insert_single_character#AppendAtCursorRepeat()
    " echom "Called insert_single_character#AppendAtCursorRepeat() with v:count=" . v:count
    let new_string = s:GetRepeatString(v:count)
    call s:AppendStringAtCursor(new_string)
    call repeat#set("\<Plug>(ISC-append-at-cursor-repeat)")
endfunction
" }}}

" Fast Insert/Append Enter at cursor {{{
function! insert_single_character#InsertEnterAtCursorDotRepeat()
    function! s:inner(...) closure abort
        let s:last_count = v:count1
        let enter_string = repeat("\<CR>", s:last_count)
        execute "keepjumps normal! i" . enter_string . "\<Esc>"
    endfunction
    let &opfunc=get(funcref('s:inner'), 'name')
    return 'g@l'
endfunction

function! insert_single_character#InsertEnterAtCursor()
    let s:last_count = v:count1
    let enter_string = repeat("\<CR>", s:last_count)
    execute "keepjumps normal! i" . enter_string
    call repeat#set("\<Plug>(ISC-insert-enter-at-cursor)")
endfunction

function! insert_single_character#AppendEnterAtCursorDotRepeat()
    function! s:inner(...) closure abort
        let s:last_count = v:count1
        let enter_string = repeat("\<CR>", s:last_count)
        let save_cursor = getcurpos()
        execute "keepjumps normal! a" . enter_string . "\<Esc>"
        call setpos(".", save_cursor)
        call repeat#set("\<Plug>(ISC-append-enter-at-cursor)")
    endfunction
    let &opfunc=get(funcref('s:inner'), 'name')
    return 'g@l'
endfunction

function! insert_single_character#AppendEnterAtCursor()
    let s:last_count = v:count1
    let enter_string = repeat("\<CR>", s:last_count)
    let save_cursor = getcurpos()
    execute "keepjumps normal! a" . enter_string
    call setpos(".", save_cursor)
    call repeat#set("\<Plug>(ISC-append-enter-at-cursor)")
endfunction
" }}}

" Fast insert/append at start/end {{{
function! insert_single_character#InsertAtStartDotRepeat()
    function! s:inner(...) closure abort
        let new_string = s:GetInputString("insert at ^")
        " echom "insert this at start: " . new_string
        if s:last_inserted_char !=# "\<CR>"
            call s:InsertStringAtStart(new_string)
            let &opfunc=get(funcref('s:inner_repeat'), 'name')
        endif
    endfunction
    function! s:inner_repeat(...) closure abort
        let new_string = s:GetRepeatString(v:count)
        call s:InsertStringAtStart(new_string)
    endfunction
    let &opfunc=get(funcref('s:inner'), 'name')
    return 'g@l'
endfunction

" Use I to insert at ^
function! insert_single_character#InsertAtStart()
    let new_string = s:GetInputString("insert at ^")
    " echom "insert this at start: " . new_string
    if s:last_inserted_char !=# "\<CR>"
        call s:InsertStringAtStart(new_string)
        call repeat#set("\<Plug>(ISC-insert-at-start-repeat)")
    endif
endfunction

function! insert_single_character#InsertAtStartRepeat()
    let new_string = s:GetRepeatString(v:count)
    call s:InsertStringAtStart(new_string)
    call repeat#set("\<Plug>(ISC-insert-at-start-repeat)")
endfunction

function! s:InsertStringAtStart(new_string)
    let save_cursor = getcurpos()
    normal! ^
    let caret_pos = getcurpos()
    execute "keepjumps normal! I" . a:new_string . "\<Esc>"
    if caret_pos[2] <# save_cursor[2]
        call cursor(save_cursor[1], save_cursor[2] + strlen(a:new_string))
    else
        " This is not a useful use case, but I guess we can restore the cursor position nevertheless, just for consistency...
        call setpos(".", save_cursor)
    endif
endfunction

" Append at $ with A
function! insert_single_character#AppendAtEndDotRepeat()
    function! s:inner(...) closure abort
        let new_string = s:GetInputString("append at end of line")
        if s:last_inserted_char !=# "\<CR>"
            call s:AppendStringAtEnd(new_string)
            let &opfunc=get(funcref('s:inner_repeat'), 'name')
        endif
    endfunction
    function! s:inner_repeat(...) closure abort
        let new_string = s:GetRepeatString(v:count)
        call s:AppendStringAtEnd(new_string)
    endfunction
    let &opfunc=get(funcref('s:inner'), 'name')
    return 'g@l'
endfunction

function! insert_single_character#AppendAtEnd()
    let new_string = s:GetInputString("append at end of line")
    if s:last_inserted_char !=# "\<CR>"
        call s:AppendStringAtEnd(new_string)
        call repeat#set("\<Plug>(ISC-append-at-end-repeat)")
    endif
endfunction

function! s:AppendStringAtEnd(new_string)
    let save_cursor = getcurpos()
    execute "keepjumps normal! A" . a:new_string . "\<Esc>"
    call setpos(".", save_cursor)
endfunction

function! insert_single_character#AppendAtEndRepeat()
    let new_string = s:GetRepeatString(v:count)
    call s:AppendStringAtEnd(new_string)
    call repeat#set("\<Plug>(ISC-append-at-end-repeat)")
endfunction
" }}}

" Fast insert/append at start/end in Insert mode {{{
function! insert_single_character#InsertAtStartInsertMode()
    if g:InsertSingleCharacter_show_prompt_message
        echo "Enter single character to insert at ^ ..."
    endif
    let new_char = nr2char(getchar())
    let save_cursor = getcurpos()
    if new_char !=# "\<CR>"
        " echom "NOT enter"
        execute "keepjumps normal! I" . new_char . "\<Esc>"
        call setpos(".", save_cursor)
        " this breaks if a tab is entered that is converted to whitespace. oh well. You should use >> instead anyway.
        " todo: fix this with extended marks once available.
        normal! 2l
        startinsert
    else
        normal! $
        let end_of_line_pos = getcurpos()
        execute "keepjumps normal! O\<Esc>"
        " This seems to be the only way to enter insert mode at the very end of the line
        let save_cursor[1] += 1
        call setpos(".", save_cursor)
        if save_cursor[2] ==# end_of_line_pos[2]
            startinsert!
        else
            " This breaks in off by one style at the beginning of the line, but in this case you shouldn't use this command anyway...
            " I could get around this by doing a <C-o>:call virtcol(".") before doing anything else.
            " But this is a bit overkill.
            " This should be easier to fix once I solve all the confusing edge cases with extended marks.
            normal! l
            startinsert
        endif
    endif
endfunction

function! insert_single_character#AppendAtEndInsertMode()
    if g:InsertSingleCharacter_show_prompt_message
        echo "Enter single character to append at end of line ..."
    endif
    let new_char = nr2char(getchar())
    let save_cursor = getcurpos()
    if new_char !=# "\<CR>"
        execute "keepjumps normal! A" . new_char . "\<Esc>"
        call setpos(".", save_cursor)
        " Correction needed because the sequence <Esc>i moves the cursor one to the left
        normal! l
        startinsert
    else
        normal! $
        let end_of_line_pos = getcurpos()
        if save_cursor[2] ==# end_of_line_pos[2]
            execute "keepjumps normal! o\<Esc>"
            " This seems to be the only way to enter insert mode at the very end of the line
            call setpos(".", save_cursor)
            startinsert!
        else
            execute "keepjumps normal! o\<Esc>"
            call setpos(".", save_cursor)
            normal! l
            startinsert
        endif
    endif
endfunction
" }}}
