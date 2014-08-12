
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response)
{
	response.success("Hello world! this is a change");
});


Parse.Cloud.define("bears", function(request, response)
{	
	var currentUser = request.user;
	var recipientId = request.params.recipient;
	
	if (!currentUser)
	{
		response.error("Must be logged in.");
		return;
	}
	
	if (!recipientId)
	{
		response.error("Must specify recipient.");
		return;
	}
	
	var userQuery = new Parse.Query(Parse.User);
	userQuery.equalTo('objectId', recipientId);
	
	var pushQuery = new Parse.Query(Parse.Installation);
	pushQuery.matchesQuery('user', userQuery);
	
	Parse.Push.send({
		where: pushQuery,
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
	
});
