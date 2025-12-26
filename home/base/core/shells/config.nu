# Configure Nushell history settings
$env.config.history.file_format = "sqlite"  # Use SQLite for history storage
$env.config.history.max_size = 5_000_000  # Set maximum history size

# Isolation between multiple Nushell sessions
$env.config.history.isolation = true  # Prevent history from mixing across sessions

# Miscellaneous Settings
$env.config.show_banner = false  # Disable the welcome banner at startup
$env.config.rm.always_trash = true  # Always move files to trash instead of permanent deletion
$env.config.recursion_limit = 50  # Set the recursion limit for commands

# Add local bin to PATH for convenience
use std/util "path add"
path add "~/.local/bin"

# Remove duplicate directories from PATH
$env.PATH = ($env.PATH | uniq)
