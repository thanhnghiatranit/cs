<%@page
	import="com.sun.org.apache.xml.internal.security.transforms.params.InclusiveNamespaces"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>T001_Login</title>
<script type="text/javascript" src="WebContent/js/error.js"></script>
</head>
<body style="background-color: #66ffff;">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h2 style="color: red;">Tranning</h2>
			<hr>
			<p>Login</p>
		</div>
		<div class="panel-body">
			<div class="row">
				<h2 style="text-align: center; color: blue">LOGIN</h2>
				<center>
					<p style="text-align: center">
						<label id="lblErrorMessage"></label>
					</p>
				</center>
			</div>

			<form class="form-control" id="myFormLogin" style="text-align: center"
				action="Login" method="post">
				<div class="row">
					<div class="form-group">
						<label>User Id:</label> <input
							<%=request.getAttribute("username")%> id="txtUserID"
							name="txtUserID" style="margin-left: 14px" type="text" value="" />
					</div>
					<div class="form-group" style="margin-top: 10px;">
						<label>Password:</label> 
						<input <%=request.getAttribute("password")%> id="txtPassword"
							name="txtPassword" type="password" value="" />
					</div>
				</div>

				<div class="row">
					<div class="form-group" style="margin-top: 20px">

						<input type="hidden" id="modeLogin" name="modeLogin"/>
						<input onclick="Login()" type="button" name="btnLogin"
							style="margin-left: 50px" value="Login" /> 
							<input type="button"
							name="btnClear" onclick="LoginClear()" style="margin-left: 100px"
							value="Clear"/>
					</div>
			</form>

		</div>


	</div>



</body>

</html>
