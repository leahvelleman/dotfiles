" Endwise is easy. It just wants a list of tagnames and a recipe for
" forming an end tag given its start tag. It does require a specific list,
" though — it won't just end any old thing.

let block_tags = ['if', 'page', 'pages', 'table', 'tab', 'tabs']

let b:endwise_addition = '{% /& %}' 
let b:endwise_words = join(block_tags, ',')
let b:endwise_syngroups = 'djangoTagBlock,djangoStatement'



" Matchup is trickier. We're going to need to construct a really hairy list of
" list of regexes. Let's do it with helper functions so there's some chance of
" it being maintainable.

" Ok, here goes. First, given a tagname, get regexes that recognize...

" ...the open tag (including possible attributes)
function! s:open_tag(tagname)
  return '{%\s*' . a:tagname . '\s[^%]*\s*%}\ze'
endfunction

" ...the close tag
function! s:close_tag(tagname)
  return '{%\s*/' . a:tagname . '\s*%}\ze'
endfunction

" ...and that tagname as a middle tag or empty element
function! s:middle_tag(tagname)
  return '{%\s*'. a:tagname . '\s*/%}\ze'
endfunction

let b:any_open_tag = s:open_tag('\w\+')
let b:any_close_tag = s:close_tag('\w\+')

" (The `\ze`s here are to convince vim-matchup to recognize the ending curly
" brace as part of the tag name. I don't fully understand why it's necessary,
" or why it works, but here we are.)

" Next, given 
"  - an opening tagname (or regex)
"  - optionally some middle tagnames (or regexes)
"  - a close tagname (or regex)
" construct a colon-separated list of regexes that vim-matchup will use to
" look for the tag block.

function! s:tag_block_regex(tagnames)
  let out = s:open_tag(a:tagnames[0])
  for tagname in a:tagnames[1:-2]
    let out = out . ":" . s:middle_tag(tagname)
  endfor
  let out = out . ":" . s:close_tag(a:tagnames[-1])
  return out
endfunction

" Finally, we can construct our comma-separated list of colon-separated lists
" of regexes. (Whee!) Start with exceptions (currently only one, to handle the
" middle 'else' tag in an 'if' block), finish up with a general case that
" matches arbitrary tagnames.
let b:match_words = 
      \         s:tag_block_regex(['if', 'else', 'if']) 
      \ . ',' . s:tag_block_regex(['\(\w\+\)', '\1'])


" TODO make this skip middle tags

" Ascend the hierarchy of opening matches until we hit one that matches the
" open tag regexp. If [% -- which ought to move to the next-highest opening tag --
" stops actually causing us to move, we're stuck, we're not *in* a matching
" start-end pair, and we can give up.

function! GoToOuterOpenTag()
  while search('\%#' . b:any_open_tag) == 0 
    let old_head_pos = getpos('.')
    normal [%
    let head_pos = getpos('.')
    if old_head_pos == head_pos
      return 0 " We've stopped progressing in our search for an open tag. Give up.
    endif
  endwhile
  return 1
endfunction


" If we can find an opening tag, then get its location and the location of its
" close-tag counterpart.

function OuterTagBlockPositions()
  if GoToOuterOpenTag()
    let head_pos = getpos('.')
    normal %
    let tail_pos = getpos('.')
    return ['v', head_pos, tail_pos]
  else
    return 0
  endif
endfunction

function InnerTagBlockPositions()
  if GoToOuterOpenTag()
"Find end of tag
    normal ]} 
    let head_pos = getpos('.')
    if head_pos[2] + 1 == col('$')
      let head_pos[2] = 0
      let head_pos[1] += 1
    else
      let head_pos[2] += 1
    endif
    normal %
" Find start of tag
    normal [{
    let tail_pos = getpos('.')
    if tail_pos[2] == 1
      let tail_pos[2] = col([tail_pos[1] - 1, '$'])
      let tail_pos[1] -= 1
    else
      let tail_pos[2] -= 1
    endif
    normal %
    return ['v', head_pos, tail_pos]
  else
    return 0
  endif
endfunction

call textobj#user#plugin('markdoctag', {
\   '-': {
\     'select-a-function': 'OuterTagBlockPositions',
\     'select-a': 'am',
\     'select-i-function': 'InnerTagBlockPositions',
\     'select-i': 'im',
\   },
\ })
