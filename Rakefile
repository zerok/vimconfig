require "ftools"

task :default => [
  "vim/autoload/pathogen.vim",
]

file "vim/autoload/pathogen.vim" do
  FileUtils.mkdir_p "vim/autoload"
  File.copy("pathogen/autoload/pathogen.vim", "vim/autoload/pathogen.vim")
end

