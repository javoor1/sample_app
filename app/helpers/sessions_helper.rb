module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    p session[:user_id]
  end


 # Remembers a user in a persistent session.
  def remember(user)
    p user
    user.remember #llama al método remember del MODEL (se llama igual que este método)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  # Returns the current logged-in user (if any).
  # Returns the user corresponding to the remember token cookie.
  # En este caso sólo lo ocupamos para el HTML y mostrar el dropdown de account para
  # users con sesión iniciada
  # Si no encuentra un user loggeado, lo busca y asigna según el session
  # al final el resultado será una instancia de un user
  # la expresión de abajo simplemente dice que @current_user = @current_user OR @current_user = User.find_by(id: session[:user_id])
  # es lógica, básicamente está evaluando un OR, para que la premisa OR sea cierta por lo menos uno de los dos elementos de la premisa
  # debe ser cierto. Si @current_user es nil, entonces en contexto booleano será FALSE, y por lo tanto asignará el valor del User.find...
  # por otro lado si @current_user es distinto de nil, entonces se queda con el mismo valor.  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
      p @current_user #return implícito del object model @current_user
    elsif (user_id = cookies.signed[:user_id])
      p user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
        p @current_user  #return implícito del object model @current_user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    p "*********"
    p current_user #|@||@#|@##¢∞@¬|||
    p "*********"
    p forget(current_user) #ejecuta el método anterior y obtiene el objeto tipo User
    p "*********"
    session.delete(:user_id)
    p @current_user = nil
  end


  # Forgets a persistent session.
  def forget(user)
    p user
    p user.id
    user.forget #Está llamando al método forget pero en el MODEL, se llama igual a este método y por eso es confuso.
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end