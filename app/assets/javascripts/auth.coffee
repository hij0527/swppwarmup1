error_msg = (code) ->
	switch code
		when -1 then "The user name should be 5~20 characters long. Please try again."
		when -2 then "The password should be 8~20 characters long. Please try again."
		when -3 then "This user name already exists. Please try again."
		when -4 then "Invalid username and password combination. Please try again. "
		else "Undefined error."

welcome = (username, count) ->
	welcome_msg = "Welcome " + username + " <br> You have logged in " + count.toString() + " times."
	$("#welcome_msg").text(welcome_msg)

$ ->
	$("#login_button").click ->
		$.ajax
			type: "post"
			url: "/login"
			dataType: "json"
			data:
				username: $("#username").val()
				password: $("#password").val()
			error: (jqXHR, status, errorThrown) ->
				$("#error_msg").text(error_msg(jqXHR.responseJSON["error_code"]))
			success: (resp, status) ->
				welcome(resp["user_name"], resp["login_count"])

	$("#signup_button").click ->
		$.ajax
			type: "post"
			url: "/signup"
			dataType: "json"
			data:
				username: $("#username").val()
				password: $("#password").val()
			error: (jqXHR, status, errorThrown) ->
				$("#error_msg").text(error_msg(jqXHR.responseJSON["error_code"]))
			success: (resp, status) ->
				welcome(resp["user_name"], resp["login_count"])

$ ->
	$("#logout_button").click ->
		$.ajax
			type: "post"
			url: "/logout"

