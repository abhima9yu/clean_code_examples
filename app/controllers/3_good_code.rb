# Methods should only be one level of abstraction

def interpret(code)
  tokens = tokenize(code)
  ast = lex(tokens)
  parse(ast)
end

def tokenize(code)
  regexes = [
    # ...
  ]
  statements = code.split(' ')

  regexes.each_with_object([]) do |regex, tokens|
    statements.each do |statement|
      # tokens.push(...)
    end
  end
end

def lex(tokens)
  tokens.map do |token|
    # ...
  end
end

def parse(ast)
  ast.map do |node|
    # ...
  end
end





