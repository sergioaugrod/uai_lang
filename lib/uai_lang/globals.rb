Globals = {}

Globals['Class']  = UaiLang::Runtime::Class.new
Globals['Object'] = UaiLang::Runtime::Class.new
Globals['Number'] = UaiLang::Runtime::Class.new
Globals['String'] = UaiLang::Runtime::Class.new

root_self = Globals['Object'].new
Globals['RootContext'] = UaiLang::Runtime::Context.new(root_self)

Globals['TrueClass']  = UaiLang::Runtime::Class.new
Globals['FalseClass'] = UaiLang::Runtime::Class.new
Globals['NilClass']   = UaiLang::Runtime::Class.new

Globals['true']  = Globals['TrueClass'].new_with_value(true)
Globals['false'] = Globals['FalseClass'].new_with_value(false)
Globals['nil']   = Globals['NilClass'].new_with_value(nil)

Globals['Class'].define_method(:new) do |receiver, _arguments|
  receiver.new
end

Globals['Object'].define_method(:print) do |_receiver, arguments|
  puts(arguments.first.value)
  Globals['nil']
end
