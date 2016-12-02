class String
  # Simple classify to rename our hooks to their proper class
  #
  # charmkit config-changed
  #
  # This will load config-changed.rb and classify it's name to
  # ConfigChanged.
  #
  # Note most libraries use '_'(underscore) for word separation whereas
  # Juju hooks are '-'(hyphenated).
  def classify
    return self.split('-').collect!{ |w| w.capitalize }.join
  end
end
