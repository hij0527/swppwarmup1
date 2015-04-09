error_msg = (code) ->
	switch code
		when -1 then "The user name should be 5~20 characters long. Please try again."
		when -2 then "The password should be 8~20 characters long. Please try again."
		when -3 then "This user name already exists. Please try again."
		when -4 then "Invalid username and password combination. Please try again. "
		else "Undefined error."

welcome = (username, count) ->
	welcome_msg = "Welcome " + username + " <br> You have logged in " + count.toString() + " times."
	$("#msg_box").html(welcome_msg)
	$("#main").hide()
	$("#welcome").show()

render_main = () ->
	$("#msg_box").text("Please enter your credentials below")
	$("#error_msg").text("")
	$("#main").show()
	$("#welcome").hide()

$ ->
	render_main()

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

$ ->
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
			success:
				render_main()
