<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JInternalFrame.JDesktopIcon"%>
<%@page import="fjs.cs.dao.MSTCUSTOMER_DAO"%>
<%@page import="fjs.cs.dao.MSTCUSTOMER"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="fjs.cs.common.JdbcSQLServerConnection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>T002_Search</title>
</head>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
table {
	border-collapse: collapse;
	width: 100%;
}

th,td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

tr:nth-child(even) {
	background-color: #ffffff;
}
</style>

<script type="text/javascript" src="WebContent/js/error.js"></script>

<body style="background: #66ffff">

	<div class="container">
		<h2 style="color: red;">Training</h2>
		<hr>
		<p>Login > Search Customer > Edit</p>

		<form class="form-group" action="Login" method="post"
			id="myFormLogout">
			<div class="form-group">
				<div class="col-sm-11">
					Welcome:
					<%=session.getAttribute("txtUserID")%>
				</div>
				<div class="col-sm-1" style="margin-bottom: 5px">
<!-- 					<input type="hidden" id="modeLogin" name="modeLogin"> <input -->
<!-- 						type="button" value="Logout" onclick="Logout()"> <br> -->

<button onclick="location.href='http://localhost:8080/CustomersSystem/Login'" type="button">Logout</button>

				</div>
				<div>
					<input class="form-control input-sm"
						style="background: blue; margin-bottom: 10px"></input>
				</div>
		</form>
		<center>
			<label id="lblErrorMessage"></label>
		</center>
		<%
			List<MSTCUSTOMER> listCustomer = new ArrayList<MSTCUSTOMER>();
			if (null != session.getAttribute("listCustomer")) {
				listCustomer = (List<MSTCUSTOMER>) session
						.getAttribute("listCustomer");
			}
			String id = request.getParameter("id") != null ? request
					.getParameter("id") : "";
			String mode = request.getParameter("mode") != null ? request
					.getParameter("mode") : "";
			MSTCUSTOMER_DAO dao = new MSTCUSTOMER_DAO();

			if (id != "") {
				listCustomer = dao.getListCustomerByID(id);
			}

			MSTCUSTOMER customer = listCustomer.size() > 0 ? listCustomer
					.get(0) : null;
			String cusid = "";
			String cusname = "";
			String cussex = "";
			String cusbirthday = "";
			String cusemail = "";
			String cusaddress = "";

			if (customer != null) {
				cusid = customer.getCustomer_ID() != null ? customer
						.getCustomer_ID() : "";
				cusname = customer.getCustomer_Name() != null ? customer
						.getCustomer_Name() : "";
				cussex = customer.getSex() != null ? customer.getSex() : "";
				cusbirthday = customer.getBirthday() != null ? customer
						.getBirthday() : "";
				cusemail = customer.getEmail() != null ? customer.getEmail()
						: "";
				cusaddress = customer.getAddress() != null ? customer
						.getAddress() : "";
			}
		%>
		<form action="Edit" method="post" style="text-align: center"
			id="myFormEdit">
			<div <%=!mode.equals("view") ? "hidden" : ""%> class="row"></div>
			<div class="form-group">
					<label style="margin-right: 47px;">Customer Id</label> <input
						id="txtCustomer_Id" disabled name="txtCustomer_Id" type="text"
						value="<%=mode.equals("view") ? cusid : ""%>" />
			</div>
			<!-- 				</div> -->
			<div class="form-group" style="margin-top: 10px;">
				<label style="margin-right: 23px;">Customer Name</label> <input
					id="txtCustomer_name" name="txtCustomer_name"
					value="<%=mode.equals("view") ? cusname : ""%>" />
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label style="margin-right: 205px;">Sex</label> <select
					style="margin-right: 0;" id="txtSex" name="txtSex"
					selected="selected">
					<option></option>
					<option value="0"
						<%=mode.equals("view") ? (cussex.equals("0") ? "selected"
					: "") : ""%>>Male
					</option>
					<option value="1"
						<%=mode.equals("view") ? (cussex.equals("1") ? "selected"
					: "") : ""%>>Female
					</option>
				</select>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label style="margin-right: 65px;">Birthday</label> <input
					type="email" style="margin-left: 8px;" id="txtBirthday"
					name="txtBirthday"
					value=<%=mode.equals("view") ? cusbirthday : ""%>>
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label style="margin-right: 85px;">Email</label> <input
					style="margin-left: 7px;" id="txtEmail" name="txtEmail"
					value="<%=mode.equals("view") ? cusemail : ""%>" />
			</div>
			<div class="form-group" style="margin-top: 10px;">
				<label style="margin-right: 85px;">Address</label>
				<textarea id="txtAddress" name="txtAddress" value=""><%=mode.equals("view") ? cusaddress : ""%></textarea>
			</div>
			<div class="form-group">
				<input name="modeEdit" hidden id="modeEdit"> 
				<input type="button" value="Save" class="btn btn-default" style="margin-top: 20px" onclick="EditError()" /> 
				<input type="button" onclick="EditClear()" value="Clear" class="btn btn-default" style="margin-top: 20px; margin-left: 150px" />
			</div>
		</form>
</body>

</html>
