# vim-codic

`vim-codic` is the plugin which interacts [codic](https://codic.jp/) API
and translate Japanese to English. 
[codic](https://codic.jp/) API translates based on programming/engineering,
so it might be useful while programming code and cannot come up the proper
name of function/variable in English.

The API capable of using project specific translate engine, but not 
implemented yet, so system dictionary will be used.

## Install

- NeoBundle install:

```vim
Neobundle yasuharu519/vim-codic
```

- Manual install:

Please put the distributed files in to path included in `runtimepath`

## Usage

In order to use this plugin, you need `access token` of
[codic](https://codic.jp/).
You can get the `access token` from [here](https://codic.jp/my/api_status)
after you signed up and logged in the service.
After you get the `access token`, you need to define `g:vim_codic_access_token`
somewhere on your vimrc file like following,

```vim
let g:vim_codic_access_token = "<your access token here>"
```

If you setup `access token` properly, then now you can use `vim-codic` command.
If you type like following on normal mode,

```vim
:VimCodic
```

you will be asked the text you want to translate to English like,

```vim
Input: 
```

then you put the text as you like and translated text will be inserted.

## Customize

### `g:vim_codic_casing`

You can change casing style of output from `camel`, `pascal`,
`lower underscore`, `upper underscore`, `hyphen`.
If default, `camel` is selected.


## License

The source code is released under the MIT License, see LICENSE.txt

