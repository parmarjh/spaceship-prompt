# Ruby `ruby`

!!! important "За замовчуванням ця секція рендериться асинхронно"

!!! info
    [**Ruby**](https://www.ruby-lang.org) is a dynamic, reflective, object-oriented, general-purpose programming language.

The `ruby` section displays the version of Ruby. This section supports [rvm-prompt](https://rvm.io/workflow/prompt), [chruby](https://github.com/postmodern/chruby), [rbenv](https://github.com/rbenv/rbenv) and [asdf](https://asdf-vm.com) version managers.

This section is displayed only when the current directory is within a Ruby project, meaning:

* Upsearch finds a `Gemfile` or `Rakefile` file
* The current directory contains any `.rb` file

## Опції

| Змінна                  |              Default               | Meaning                                 |
|:----------------------- |:----------------------------------:| --------------------------------------- |
| `SPACESHIP_RUBY_SHOW`   |               `true`               | Показати секцію                         |
| `SPACESHIP_RUBY_ASYNC`  |               `true`               | Render section asynchronously       |   |
| `SPACESHIP_RUBY_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Префікс секції                          |
| `SPACESHIP_RUBY_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Суфікс секції                           |
| `SPACESHIP_RUBY_SYMBOL` |                `💎·`                | Символ, що відображається перед секцією |
| `SPACESHIP_RUBY_COLOR`  |               `red`                | Колір секції                            |
