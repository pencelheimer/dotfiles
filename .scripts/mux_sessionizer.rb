#!/usr/bin/env ruby

bookmarks = [
  "~/dotfiles",
  "~/krsnktska",
  "~/dotfiles/.scripts",
]

search_paths = [
  "~/Documents/nure/semester-4",
  "~/dotfiles/.config",
  "~/stuff/projects",
  "~/stuff/projects/Shum",
]

ignore = Regexp.union([
	/\.git/,
	/target/,
	/build/,
	/__pycache__/,
	/venv/,
])

mux = ARGV[0] == nil ? "zellij" : ARGV[0]

finders = {
  "fd" => ["fd .", "--type d --max-depth 1 --hidden"],
  "find" => ["find", "-mindepth 1 -maxdepth 1 -type d"],
}

def command?(name)
  `which #{name}`
  $?.success?
end

fd, fd_opts = nil, nil
finders.each { |finder, config|
  if command? finder then
    fd, fd_opts = config
    break
  end
}

search_paths.map! { |path| File.expand_path(path).gsub(/ /, '\ ')}
found = `#{fd} #{search_paths.join(" ")} #{fd_opts}`.split("\n")
found.filter! { |path| !(path =~ ignore) }

paths = (found + bookmarks).map do |path|
  path.gsub(ENV["HOME"], '~').gsub(/\/$/, '')
end.join("\n")

selected_item = `echo "#{paths}" | fzf --height 100% --tac`
exit(0) if selected_item.empty?
selected_path = File.expand_path selected_item

session_name = File.basename(selected_path).gsub(/\.| /, "_")

case mux
when "zellij"
  if ENV["ZELLIJ"].nil? || ENV["ZELLIJ"].empty?
    Dir.chdir(selected_path)

    `zellij attach "#{session_name}" -c`
    exit(0)
  end

`zellij pipe --plugin switch -- "--session #{session_name} --cwd #{selected_path} --layout default"`
when "tmux"
  tmux_running = !`pgrep tmux`.strip.empty?

  if (ENV["TMUX"].nil? || ENV["TMUX"].empty?) && !tmux_running
    `tmux new-session -s #{session_name} -c #{selected_path}`
    exit(0)
  end

  `tmux has-session -t=#{session_name}`
  session_exists = $?.success?

  if !session_exists
    `tmux new-session -ds #{session_name} -c #{selected_path}`
  end

  `tmux switch-client -t #{session_name}`
else
  puts "The fuck is #{mux}?"
end
