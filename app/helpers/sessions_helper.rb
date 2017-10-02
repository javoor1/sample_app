module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    p session[:user_id]
  end


  # Returns the current logged-in user (if any).
  # En este caso sólo lo ocupamos para el HTML y mostrar el dropdown de account para
  # users con sesión iniciada
  # Si no encuentra un user loggeado, lo busca y asigna según el session
  # al final el resultado será una instancia de un user
  def current_user
  	#la expresión de abajo simplemente dice que @current_user = @current_user OR @current_user = User.find_by(id: session[:user_id])
  	# es lógica, básicamente está evaluando un OR, para que la premisa OR sea cierta por lo menos uno de los dos elementos de la premisa
  	# debe ser cierto. Si @current_user es nil, entonces en contexto booleano será FALSE, y por lo tanto asignará el valor del User.find...
  	# por otro lado si @current_user es distinto de nil, entonces se queda con el mismo valor.
    @current_user ||= User.find_by(id: session[:user_id])
  end


  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
  	puts "dentro de log_out"
  	# p current_user
    session.delete(:user_id)
    @current_user = nil
  end

end