class Snippet < ActiveRecord::Base
  include PathFormatter

  belongs_to :vault

  validates_presence_of :name, :language, :code, :vault_id

  before_save :format_name

  enum language: [ :nohighlight, :accesslog, :actionscript, :apache, :applescript, :armasm, :asciidoc, :aspectj, :autohotkey, :autoit, :avrasm, :axapta, :bash, :brainfuck, :cal, :capnproto, :ceylon, :clojure, :cmake, :coffeescript, :cpp, :crystal, :cs, :css, :d, :dart, :delphi, :diff, :django, :dns, :dockerfile, :dos, :dust, :elixir, :elm, :erb, :erlang, :fix, :fortran, :fsharp, :gams, :gcode, :gherkin, :glsl, :go, :golo, :gradle, :groovy, :haml, :handlebars, :haskell, :haxe, :xml, :http, :inform7, :ini, :irpf90, :java, :javascript, :json, :julia, :kotlin, :lasso, :less, :lisp, :livecodeserver, :livescript, :lua, :makefile, :markdown, :mathematica, :matlab, :mel, :mercury, :mizar, :mojolicious, :monkey, :nginx, :nimrod, :nix, :nsis, :objectivec, :ocaml, :openscad, :oxygene, :parser3, :perl, :pf, :php, :powershell, :processing, :profile, :prolog, :protobuf, :puppet, :python, :q, :r, :rib, :roboconf, :rsl, :ruby, :ruleslanguage, :rust, :scala, :scheme, :scilab, :scss, :smali, :smalltalk, :sml, :sql, :stata, :step21, :stylus, :swift, :tcl, :tex, :thrift, :tp, :twig, :typescript, :vala, :vbnet, :vbscript, :verilog, :vhdl, :vim, :x86asm, :xl, :xquery, :zephir ]
end
