FROM gitpod/workspace-base

# Install dependencies
RUN sudo apt-get install -y build-essential curl libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5

# ghcup is a replacement for the haskell platform. It manages the development env easily.
# We use the official instalation script
RUN sudo curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Add ghcup to path
ENV PATH=${PATH}:${HOME}/.ghcup/bin

# Set up the environment. This will install the default versions of every tool.
RUN ghcup install ghc
RUN ghcup install hls
RUN ghcup install cabal

# Generate the right cabal file. Using cabal init after ghc installation ensures that the right version of base is used
# Otherwise, the template would become deprecated as long as ghcup decides to pick up a different version of ghc.
RUN cabal init
