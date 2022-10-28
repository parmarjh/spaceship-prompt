# Créé une section spéciale

Ce guide vise à vous aider à créer votre première section personnalisée.

## Règles pour les sections

Voici les recommandations à suivre lors de la création d'une section pour maintenir la fluidité et la propreté du vaisseau spatial.

### La section ne doit pas encombrer l'invite

Avoir trop en prompt semble laid. Il est préférable de le limiter au minimum des informations nécessaires.

* **Bien :** `🚀 v1.2.3`
* **Mauvais :** `🚀 spasheship#c3BhY2VzaGlw`

### La section devrait être utile pour être au courant de

Les changements de valeur sont-ils assez fréquents, donc ils doivent être affichés rapidement ? Serait-il utile pour d'autres utilisateurs ? Peut-être qu'il y a une raison d'exécuter une commande au lieu de l'encombrement.

* **Bon :** git statut/branche, version d'exécution via le gestionnaire de version, etc
* **Mauvaise :** version du cadre linguistique, des versions de projets réglées, etc

### La section devrait être rapide

Si votre section effectue un contrôle minutieux, trouvez un moyen de le rendre plus rapide. Utiliser un rendu asynchrone pour effectuer des tâches lourdes. La section devrait être rapide:

* **Asynchro :** s'il exécute des commandes externes, effectue des calculs complexes, lisant des fichiers volumineux
* **Synchronisation :** si elle vérifie la disponibilité de la commande, vérifie la valeur de la variable d'environnement

### Suivre la convention de nommage pour les options

Toutes les options de l'invite suivent une pratique spécifique pour qu'il soit facile à retenir : `SPACESHIP_SECTION_<OPTION>[_PROPERTY]`. La règle est simple : lorsque vous nommez de nouvelles propriétés, gardez des parties uniques du nom jusqu'à la fin.

* **Bon:**
  ```
    SPACESHIP_GIT_STATUS_COLOR_BEHIND
    SPACESHIP_GIT_STATUS_COLOR_DIVERGED
  ```
* **Mauvais:**
  ```
    SPACESHIP_GIT_STATUS_BEHIND_COLOR
    SPACESHIP_GIT_STATUS_DIVERGED_COLOR
  ```

  Ici, `GIT_STATUS` est *section*, `COLOR` est *option* et `BEHIND` ou `DIVERGÉ` est *propriété*.

## Créer une section

La façon la plus simple de créer une section est d'utiliser un dépôt de template pour la section Spaceship.

[:fontawesome-brands-github: Utiliser un modèle de section](https://github.com/spaceship-prompt/spaceship-section ""){.md-button}

Ce dépôt de boilerplate contient un modèle pour une section et sa documentation, a configuré la version et le flux de travail de test. Explorez le dépôt pour en savoir plus.

Ouvrez un fichier [`spaceship-section.plugin.zsh`](https://github.com/spaceship-prompt/spaceship-section/blob/main/spaceship-section.plugin.zsh) pour un exemple de section personnalisée.

## Répartition typique de la section

Voici un exemple de section typique pour le vaisseau spatial. Faites attention à quelques moments cruciaux :

- Définir les options pour la personnalisation. Leurs noms devraient commencer par `SPACESHIP_`.
- Chaque nom de section de vaisseau spatial doit commencer par `vaisseau spatial_` (par exemple `vaisseau spatial`). This is a convention that is used to identify the section.
- Show section only where it's needed (in directories which contains specific files, when a specific command is available, etc).

Sections are defined by [`spaceship::section` API](/api/section/). You can use [general purpose utilities](/api/utils/) for performing common tasks in a section.

Typical section might look like this:

```zsh
#
# Foobar
#
# Foobar is a supa-dupa cool tool for making you development easier.
# Link: https://www.foobar.xyz

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_FOOBAR_SHOW="${SPACESHIP_FOOBAR_SHOW=true}"
SPACESHIP_FOOBAR_ASYNC="${SPACESHIP_FOOBAR_ASYNC=true}"
SPACESHIP_FOOBAR_PREFIX="${SPACESHIP_FOOBAR_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_FOOBAR_SUFFIX="${SPACESHIP_FOOBAR_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_FOOBAR_SYMBOL="${SPACESHIP_FOOBAR_SYMBOL="🍷 "}"
SPACESHIP_FOOBAR_COLOR="${SPACESHIP_FOOBAR_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show foobar status
# spaceship_ prefix before section's name is required!
# Otherwise this section won't be loaded.
spaceship_foobar() {
  # If SPACESHIP_FOOBAR_SHOW is false, don't show foobar section
  [[ $SPACESHIP_FOOBAR_SHOW == false ]] && return

  # Check if foobar command is available for execution
  spaceship::exists foobar || return

  # Show foobar section only when there are foobar-specific files in current
  # working directory.

  # spaceship::upsearch utility helps finding files up in the directory tree.
  local is_foobar_context="$(spaceship::upsearch foobar.conf)"
  # Here glob qualifiers are used to check if files with specific extension are
  # present in directory. Read more about them here:
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html
  [[ -n "$is_foobar_context" || -n *.foo(#qN^/) || -n *.bar(#qN^/) ]] || return

  local foobar_version="$(foobar --version)"

  # Check if tool version is correct
  [[ $tool_version == "system" ]] && return

  # Display foobar section
  # spaceship::section utility composes sections. Flags are optional
  spaceship::section::v4 \
    --color "$SPACESHIP_FOOBAR_COLOR" \
    --prefix "$SPACESHIP_FOOBAR_PREFIX" \
    --suffix "$SPACESHIP_FOOBAR_SUFFIX" \
    --symbol "$SPACESHIP_FOOBAR_SYMBOL" \
    "$foobar_status"
}
```

Take a look at [Contribution guidelines](//github.com/spaceship-prompt/spaceship-prompt/blob/master/CONTRIBUTING.md) for further information.

## Share your section with others

The next step is to share your section with the community.

Open a discussion topic on our Discussion forum:

[Add to Registry](https://github.com/spaceship-prompt/spaceship-prompt/blob/master/docs/registry/external.json ""){.md-button} [Share on forum](https://github.com/spaceship-prompt/spaceship-prompt/discussions/new?category=show-and-tell&title=Section%20for%20[tool] ""){.md-button}
