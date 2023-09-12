
# Methods should do one thing
def email(client)
 
end

def email_clients(clients)
  clients.each { |client| email(client) }
end

def active(objects)
  objects.select { |object| active?(object) }
end

def active?(object)
  record = database.lookup(object)
  record.active?
end

email_clients(active(clients))


