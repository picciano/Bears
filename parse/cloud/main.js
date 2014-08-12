
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response)
{
	response.success("Hello world!");
});


Parse.Cloud.define("bears", function(request, response)
{	
	var currentUser = request.user;
	if (currentUser)
	{
		// everyone for now
		var query = new Parse.Query(Parse.Installation);
		
		Parse.Push.send({
			where: query,
			data: {
				alert: "BEARS from " + request.user.get("username").toUpperCase(),
				badge: "Increment"
			}
		}, {
			success: function() {
				response.success("Hello " + request.user.get("username"));
			},
			error: function(error) {
				response.error(error.message)
			}
		});
		
	}
	else
	{
		response.error("Must be logged in.")
	}
	
});
