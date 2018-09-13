<%@page import="fjs.cs.common.Utils"%>
<%@page import="java.util.Date"%>
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
.odd {
	background-color: white;
}

.even {
	background-color: #66ffff;
}

table {
	border-collapse: collapse;
	border: 3px solid #2aa22a;
	width: 100%;
}

th {
	background: #2aa22a;
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #2aa22a;
	padding: 8px;
}

td {
	padding: 8px;
	text-align: left;
}
</style>
<%
	List<MSTCUSTOMER> listCustomer = new ArrayList<MSTCUSTOMER>();
	if (null != session.getAttribute("listCustomer")) {
		listCustomer = (List<MSTCUSTOMER>) session
				.getAttribute("listCustomer");
	}
%>
<body style="background: #66ffff" onload="alternate('myTable')">

	<div class="container">
		<h2 style="color: red;">Training</h2>
		<hr style="background-color: black">
		<p>Login > Search Customer</p>

		<form class="form-group" action="Login" method="post"
			id="myFormLogout">
			<div class="form-group">
				<div class="col-sm-11">
					Welcome:
					<%=session.getAttribute("txtUserID")%>
				</div>
				<div class="col-sm-1" style="margin-bottom: 5px">
					<input type="hidden" id="modeLogin" name="modeLogin"> <input
						type="button" value="Logout" onclick="Logout()"> <br>
				</div>
				<div>
					<input class="form-control input-sm"
						style="background: blue; margin-bottom: 10px"></input>
				</div>
		</form>
		<form class="form-group" action="Search" method="post"
			id="myFormSearch">
			<div class="form-group" style="background: #ffff33">
				<label id="llbCustomername">Customer name:</label> <input
					id="txtsearchName" name="txtsearchName" type="text"
					value="<%=session.getAttribute("CUSNAME")%>" /> <label>Sex</label>
				<select id="llbSex" name="llbSex" selected="selected">
					<option></option>
					<option value="0"
						<%=session.getAttribute("CUSSEX").equals("0") ? "selected"
					: ""%>>Male</option>
					<option value="1"
						<%=session.getAttribute("CUSSEX").equals("1") ? "selected"
					: ""%>>Female</option>
				</select> <label>Birthday:</label> <input id="txtBirthdayFrom"
					name="txtBirthdayFrom"
					value="<%=session.getAttribute("CUSBIRTHDAY1")%>">~ <input
					id="txtBirthdayTo" name="txtBirthdayTo"
					value="<%=session.getAttribute("CUSBIRTHDAY2")%>"> <input
					type="hidden" id="modeSearch" name="modeSearch"> <input
					id="btnSearch" name="btnSearch" type="button" class="btn"
					onclick="Search()" value="Search" />
			</div>
			<%
				int start = 0, maxRecord = 15, sizeList = 0;
				start = (Integer) session.getAttribute("start");
				maxRecord = (Integer) session.getAttribute("maxRecord");
				sizeList = (Integer) session.getAttribute("sizeList");
			%>
			<div class="form-group">
				<div class="row">
					<div class="col-sm-10">
						<%
							if (sizeList <= 15) {
						%>
						<input id="btnFirst" name="btnFirst" type="button" disabled="disabled" value="<<" onclick="pagingFirst()">
						<input id="btnPrevious" name="btnPrevious" type="button" disabled="disabled" value="<" onclick="pagingPrevious()">
						<input id="btnNext" name="btnNext" type="button" disabled="disabled" value=">" onclick="pagingNext()">
						<input id="btnLast" name="btnLast" type="button" disabled="disabled" value=">>" onclick="pagingLast()">
					</div>
					<div class="col-sm-2">
						<%
							} else {
						%>
						<input id="btnFirst" name="btnFirst" type="button" value="<<" onclick="pagingFirst()">
						<input id="btnPrevious" name="btnPrevious" type="button" value="<" onclick="pagingPrevious()">
						<input id="btnNext" name="btnNext" type="button" value=">" onclick="pagingNext()">
						<input id="btnLast" name="btnLast" type="button" value=">>" onclick="pagingLast()">

						<%
							}
						%>
					</div>
			</div>
			</div>
			<table id="myTable" class="list">
				<thead>
					<tr>
						<th><input type="checkbox" name="checkbox" value="checkbox"></th>
						<th>Customer ID</th>
						<th>Customer Name</th>
						<th>Sex</th>
						<th>Birthday</th>
						<th>Address</th>
					</tr>
				</thead>
				<tbody>

					<%
						for (MSTCUSTOMER customer : listCustomer) {
							//Chuyen tu string sang ngay
							Date date = Utils.stringToDate(customer.getBirthday());
							//chuyen tu ngay sang string kieu dinh dang yyyy/MM/dd
							String dateFormat = Utils.dateToString(date);
							String viewCus = "WebContent/jsp/T003.jsp?mode=view&id="
									+ customer.getCustomer_ID();
					%>
					<tr>

						<td><input type="checkbox" name="checkbox"
							id="<%=customer.getCustomer_ID()%>"
							onclick="checkedFunction(this)" value=""></td>
						<td><a href="<%=viewCus%>"><%=customer.getCustomer_ID()%></a></td>
						<td><%=customer.getCustomer_Name()%></td>
						<td><%=(customer.getSex().equals("0")) ? "Male" : "Female"%></td>
						<td><%=(customer.getBirthday() != null) ? dateFormat : ""%></td>
						<td><%=customer.getAddress()%></td>

					</tr>
				</tbody>
				<%
					}
				%>
			</table>
			<div class="col-sm-2">
				<input id="btnAddnew" class="btn btn-primary" type="button"
					value="Add New" onclick="Addnew()" style="margin-top: 20px">
			</div>
			<div class="row">
				<div class="col-sm-2">
				
					<input name="customerId" id="customerId" type="hidden"> 
					<%if(sizeList==0){ %>
					<input name="btnDelete" id="btnDelete" disabled="disabled" class="btn btn-primary" value="Delete" 
					type="button" style="margin-top: 20px" onclick="ErrorDelete()">
					 <%}else{
						 %>
					<input name="btnDelete" id="btnDelete" class="btn btn-primary" value="Delete" 
					type="button" style="margin-top: 20px" onclick="ErrorDelete()">
						 <%
					 }
					%>
				</div>
			</div>
		</form>
	</div>
	<input type="" name="start" id="start"
		value="<%=session.getAttribute("start")%>">
	<input type="" name="maxRecord" id="maxRecord"
		value="<%=session.getAttribute("maxRecord")%>">
	<input type="" name="sizeList" id="sizeList"
		value="<%=session.getAttribute("sizeList")%>">

</body>

<script type="text/javascript" src="WebContent/js/error.js"></script>

</html>
