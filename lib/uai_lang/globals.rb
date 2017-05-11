Globals = {}

Globals['Class']  = UaiLang::Runtime::Class.new
Globals['Object'] = UaiLang::Runtime::Class.new
Globals['Number'] = UaiLang::Runtime::Class.new
Globals['String'] = UaiLang::Runtime::Class.new

root_self = Globals['Object'].new
RootContext = UaiLang::Runtime::Context.new(root_self)

Globals['TrueClass']  = UaiLang::Runtime::Class.new
Globals['FalseClass'] = UaiLang::Runtime::Class.new
Globals['NilClass']   = UaiLang::Runtime::Class.new

Globals['true']  = Globals['TrueClass'].new(true)
Globals['false'] = Globals['FalseClass'].new(false)
Globals['nil']   = Globals['NilClass'].new(nil)

Globals['Class'].define_method(:new) do |receiver, arguments|
  receiver.new
end
