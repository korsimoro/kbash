#!/bin/bash
shopt -s nocasematch

if [[ "$KITWB_DOCKER_VERBOSE" == "false" ]] || [[ -z "$KITWB_DOCKER_VERBOSE" ]]; then
  export DOCKER_COMPOSE_VERBOSE=
  export KITWB_DOCKER_VERBOSE=false
else
  export DOCKER_COMPOSE_VERBOSE=--verbose
  export KITWB_DOCKER_VERBOSE=true
fi

shopt -u nocasematch

export VOLUMES="sql nosql redis logs"

has_volume() {
  VOLUME=$1
  docker volume inspect $VOLUME  >/dev/null 2>&1 || false
}


list_managed_volumes() {
  echo "The following volumes are managed"
  for V in $VOLUMES; do
    echo keyoniq.$V
  done
}

list_defined_volumes() {
  OUTPUT=$(docker volume ls | grep keyoniq | sort)
  if [ -z "$OUTPUT" ]; then
    printf "${YELLOW}No volumes have been created${NC}\n"
  else
    printf "The following volumes have been created\n"
    echo "$OUTPUT"
  fi
}

has_any_defined_volumes() {
  OUTPUT=$(docker volume ls | grep keyoniq | sort)
  [ ! -z "$OUTPUT" ]
}

log_docker_call() {
  COMMAND="$@"
  LOGLINE=$(echo `date` "$COMMAND")
  if $KITWB_DOCKER_VERBOSE; then
    printf "${YELLOW}KD-DOCKER${BLUE} $COMMAND${NC}\n"
  fi
  echo 2>&1 $LOGLINE >> "$KITWB_DEVOPS_DIR/kd.log"
}
composition() {
  build_composition
  echo $COMPOSITION
}

docker-compose() {
  COMMAND="$KITWB_DOCKER_COMPOSE_PATH $DOCKER_COMPOSE_VERBOSE $(composition ) $@"
  log_docker_call "$COMMAND"
  $KITWB_DOCKER_COMPOSE_PATH $DOCKER_COMPOSE_VERBOSE $(composition ) "$@"
}
docker() {
  COMMAND="$KITWB_DOCKER_PATH $@"
  log_docker_call "$COMMAND"
  $KITWB_DOCKER_PATH "$@"
}
docker_client_version() {
  $KITWB_DOCKER_PATH version --format '{{.Client.Version}}'
}
docker_server_version() {
  $KITWB_DOCKER_PATH version --format '{{.Server.Version}}'
}
docker_compose_version() {
  $KITWB_DOCKER_COMPOSE_PATH version --short

}

has_docker() {
  [ -x "$KITWB_DOCKER_PATH" ]
}
has_docker_compose() {
  [ -x "$KITWB_DOCKER_COMPOSE_PATH" ]
}

docker_setup_ok_and_running() {
  if ! has_docker; then
    return `false`
  fi
  if ! has_docker_compose; then
    return `false`
  fi

  MESSAGE=$($KITWB_DOCKER_PATH stats --no-stream 2>&1)
  if [[ $? -ne 0 ]]; then
    return `false`
  fi

  MESSAGE=$($KITWB_DOCKER_COMPOSE_PATH version 2>&1)
  if [[ $? -ne 0 ]]; then
    return `false`
  fi

  return `true`
}

require_functional_docker() {
  if ! has_docker; then
    printf "${RED}Docker is not functional - can not continue${NC}\n"
    printf "  No executable found at KITWB_DOCKER_PATH\n"
    printf "  KITWB_DOCKER_COMPOSE_PATH=$KITWB_DOCKER_COMPOSE_PATH\n"
    exit -1
  fi
  if ! has_docker_compose; then
    printf "${RED}Docker is not functional - can not continue${NC}\n"
    printf "  No executable found at KITWB_DOCKER_COMPOSE_PATH\n"
    printf "  KITWB_DOCKER_COMPOSE_PATH=$KITWB_DOCKER_COMPOSE_PATH\n"
    exit -1
  fi

  # make sure we can connect to the daemon
  MESSAGE=$($KITWB_DOCKER_PATH stats --no-stream 2>&1)
  if [[ $? -ne 0 ]]; then
    printf "${RED}Docker is not functional - can not continue${NC}\n"
    printf "  This command requires a functional docker installation and we\n"
    printf "  can not connect to get usage stats.\n\n"
    printf "  KITWB_DOCKER_PATH=$KITWB_DOCKER_PATH\n"
    printf "  docker response to 'stats --no-stream:$MESSAGE\n"
    exit -1
  fi
}

has_network() {
  NETWORK=$1
  docker network inspect $NETWORK  >/dev/null 2>&1 || false
}

report_docker_status() {
  printf "${GREEN}Docker support was found${NC}\n"
  printf "  docker path             = %s\n" "$KITWB_DOCKER_PATH"
  printf "  docker-compose path     = %s\n" "$KITWB_DOCKER_COMPOSE_PATH"
  printf "  ${BLUE}docker client version ${NC}  = %s\n" "$(docker_client_version )"
  printf "  ${BLUE}docker server version ${NC}  = %s\n" "$(docker_server_version )"
  printf "  ${BLUE}docker-compose version ${NC} = %s\n" "$(docker_compose_version )"
}

function setup_docker_on_windows() {
  printf "`cat << EOF
${YELLOW}Fixing windows mounts${NC}

From: https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly

Allow your user to bind a mount without a root password:
To do that, run the sudo visudo command.  This maps paths
of the form c:<windows-path> to c/<windows-path> and c:<windows-path>.

This is executed in default-env.sh as part of the shell activation.

Since this requires root power, we want it to be automatic.

To make this happen we edit the sudoers file, which has a special editor
called visudo.  When you press yes at the problem below, you will be taken
to an editor.  Goto the bottom of the file and add this line:

  ${BLUE}$USER ALL=(root) NOPASSWD: /bin/mount${NC}

That just allows your user to execute the sudo mount command without having to supply a password.

You can save the file with CTRL+X, and answer Yes to save the file
to /tmp/sudoers.tmp.

Mission complete.

You’re all set to win at life by using Docker for Windows and WSL.
EOF
`\n\n"

  read -t 25 -n 1 -p "Ready to sudo visudo (y/n)? " answer
  printf "\n"
  [ -z "$answer" ] && answer="n"  # if 'no' have to be default choice
  if [ ! "$answer" = "y" ]; then
    printf "\n${GREEN}Ok${NC}\n"
    printf "Run ${BLUE}kd setup${NC} to try again later.\n"
    exit -1
  fi

  sudo visudo

  if [ ! -d "/c" ]; then
    printf "${YELLOW}/c directory is missing, creating${NC}\n"
    sudo mkdir /c
  fi
  printf "${YELLOW}Attempting mount of /mnt/c to /c${NC}\n"
  sudo mount --bind /mnt/c /c

  SETUPLOG=/tmp/kd-setup-docker.txt
  printf "${YELLOW}Installing docker, details in ${SETUPLOG}${NC}\n"
  printf " use tail -f ${SETUPLOG} to monitor from another shell.\n"

  # https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly
  export DOCKER_CHANNEL=edge
  export DOCKER_COMPOSE_VERSION=1.21.0

  printf "${YELLOW} Update the apt package index.${NC}\n"
  sudo apt-get update 2>&1 >> $SETUPLOG

  printf "${YELLOW} Install packages to allow apt to use a repository over HTTPS.${NC}\n"
  sudo apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common  2>&1 >> $SETUPLOG

  printf "${YELLOW} Add Docker's official GPG key.${NC}\n"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  2>&1 >> $SETUPLOG

  printf "${YELLOW} Verify the fingerprint.${NC}\n"
  sudo apt-key fingerprint 0EBFCD88  2>&1 >> $SETUPLOG

  printf "${YELLOW} Pick the release channel.${NC}\n"
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     ${DOCKER_CHANNEL}"  2>&1 >> $SETUPLOG

  printf "${YELLOW} Update the apt package index.${NC}\n"
  sudo apt-get update  2>&1 >> $SETUPLOG

  printf "${YELLOW} Install the latest version of Docker CE.${NC}\n"
  sudo apt-get install -y docker-ce  2>&1 >> $SETUPLOG

  printf "${YELLOW} Allow your user to access the Docker CLI without needing root.${NC}\n"
  sudo usermod -aG docker $USER  2>&1 >> $SETUPLOG

  printf "${YELLOW} Install Docker Compose.${NC}\n"
  sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&  2>&1 >> $SETUPLOG
  sudo chmod +x /usr/local/bin/docker-compose  2>&1 >> $SETUPLOG

  KITWB_DOCKER_PATH=$(which docker)
  KITWB_DOCKER_COMPOSE_PATH=$(which docker-compose)

  printf "`cat << EOF
${YELLOW}Exposing Docker Daemon to WLS w/o TLS${NC}

From: https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly

In the general settings, you’ll want to expose the daemon without TLS.
This step is necessary so that the daemon listens on a TCP endpoint.
If you don’t do this then you won’t be able to connect from WSL.

1. Find the Docker icon in the toolbar tray
2. Right click on this icon to open the application menu
3. Select ${BLUE}Shared Drives${NC} on the left
4. Ensure that the C drive, or whatever you want to share, is slected.
5. Select ${BLUE}General${NC} on the left.
6. Select the "Expose daemon on tcp://localhost:2375 without TLS"

This may cause the docker daemon to restart.
EOF
`\n\n"

  read -t 25 -n 1 -p "Is the docker daemon ready (y/n)? " answer
  printf "\n"
  [ -z "$answer" ] && answer="n"  # if 'no' have to be default choice
  if [ ! "$answer" = "y" ]; then
    printf "\n${GREEN}Ok${NC}\n"
    printf "Run ${BLUE}kd setup${NC} to try again later.\n"
    exit -1
  fi

}


ensure_prepped_environment() {
  ensure_valid_checkout

  # disable error abort
  CHK_NETWORK=$(docker network inspect keyoniq.network 2>/dev/null)
  if [ "$CHK_NETWORK" == "[]" ]; then
    printf "${RED}keyoniq.network not found, try 'kd bench create networks'${NC}\n"
    exit -1
  fi

  for V in $VOLUMES; do
    CHK_VOLUME=$(docker volume inspect keyoniq.$V 2>/dev/null)
    if [ "$CHK_VOLUME" == "[]" ]; then
      printf "${RED}Volume keyoniq.$V not found, try 'kd bench create volumes'${NC}\n"
      exit -1
    fi
  done

}
