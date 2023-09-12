def interpret(code)
  regexes = [
    # ...
  ]
  statements = code.split(' ')

  tokens = regexes.each_with_object([]) do |regex, memo|
    statements.each do |statement|
      # memo.push(...)
    end
  end

  ast = tokens.map do |token|
    # ...
  end

  ast.map do |node|
    # ...
  end
end