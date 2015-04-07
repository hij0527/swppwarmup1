$ ->
	$.ajax
		dataType: "json"
		success: (resp, status) ->
			$("#error_msg").text(resp["username"])
		error: (resp, status) ->
			code = resp["error"]
			error_msg = ""
			if (code==-1)
				error_msg = "The user name should be 5~20 characters long. Please try again."
			else if (code == -2)
				error_msg = "The password should be 8~20 characters long. Please try again."
			else if (code == -3)
				error_msg = "This user name already exists. Please try again."
			else if (code == -4)
				error_msg = "Invalid username and password combination. Please try again. "
			else
				error_msg = "Undefined error. no hack."
			$("#error_msg").text(error_msg)
