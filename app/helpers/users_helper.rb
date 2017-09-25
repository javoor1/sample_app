module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 200 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
# Este método usa el digest para generar el mail del user
# después genera una variable gravatar_url que es un string con la
# dirección de gravatar del user.
# Después se genera un image_tag con la información del user
