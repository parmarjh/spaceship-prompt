#
#  Kubernetes (kubectl)
#
# Kubernetes is an open-source system for deployment, scaling,
# and management of containerized applications.
# Link: https://kubernetes.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_KUBECONTEXT_SHOW="${SPACESHIP_KUBECONTEXT_SHOW=true}"
SPACESHIP_KUBECONTEXT_PREFIX="${SPACESHIP_KUBECONTEXT_PREFIX=""}"
SPACESHIP_KUBECONTEXT_SUFFIX="${SPACESHIP_KUBECONTEXT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_KUBECONTEXT_TRUNC="${SPACESHIP_KUBECONTEXT_TRUNC="0"}"
SPACESHIP_KUBECONTEXT_TRUNC_SUFFIX="${SPACESHIP_KUBECONTEXT_TRUNC_SUFFIX="…"}"
SPACESHIP_KUBECONTEXT_COLOR="${SPACESHIP_KUBECONTEXT_COLOR="cyan"}"
SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW="${SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW=true}"
SPACESHIP_KUBECONTEXT_NAMESPACE_PREFIX="${SPACESHIP_KUBECONTEXT_NAMESPACE_PREFIX=' ('}"
SPACESHIP_KUBECONTEXT_NAMESPACE_SUFFIX="${SPACESHIP_KUBECONTEXT_NAMESPACE_SUFFIX=')'}"
SPACESHIP_KUBECONTEXT_COLOR_GROUPS=(${SPACESHIP_KUBECONTEXT_COLOR_GROUPS=})

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current context in kubectl
spaceship_kubectl_context() {
  [[ $SPACESHIP_KUBECONTEXT_SHOW == false ]] && return

  spaceship::exists kubectl || return

  local kube_context=$(kubectl config current-context 2>/dev/null)
  [[ -z $kube_context ]] && return
  if [[ "$SPACESHIP_KUBECONTEXT_TRUNC" != 0 ]]; then
    local orig_kube_context=$kube_context
    kube_context=$(cut -c 1-${SPACESHIP_KUBECONTEXT_TRUNC} <<< $kube_context)
    if [ "$orig_kube_context" != "$kube_context" ]; then
      kube_context="$kube_context$SPACESHIP_KUBECONTEXT_TRUNC_SUFFIX"
    fi
  fi

  if [[ $SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW == true ]]; then
    local kube_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    [[ -n $kube_namespace && "$kube_namespace" != "default" ]] && kube_context="$kube_context$SPACESHIP_KUBECONTEXT_NAMESPACE_PREFIX$kube_namespace$SPACESHIP_KUBECONTEXT_NAMESPACE_SUFFIX"
  fi

  # Apply custom color to section if $kube_context matches a pattern defined in SPACESHIP_KUBECONTEXT_COLOR_GROUPS array.
  # See Options.md for usage example.
  local len=${#SPACESHIP_KUBECONTEXT_COLOR_GROUPS[@]}
  local it_to=$((len / 2))
  local 'section_color' 'i'
  for ((i = 1; i <= $it_to; i++)); do
    local idx=$(((i - 1) * 2))
    local color="${SPACESHIP_KUBECONTEXT_COLOR_GROUPS[$idx + 1]}"
    local pattern="${SPACESHIP_KUBECONTEXT_COLOR_GROUPS[$idx + 2]}"
    if [[ "$kube_context" =~ "$pattern" ]]; then
      section_color=$color
      break
    fi
  done

  [[ -z "$section_color" ]] && section_color=$SPACESHIP_KUBECONTEXT_COLOR

  spaceship::section \
    "$section_color" \
    "$SPACESHIP_KUBECONTEXT_PREFIX" \
    "${kube_context}" \
    "$SPACESHIP_KUBECONTEXT_SUFFIX"
}
