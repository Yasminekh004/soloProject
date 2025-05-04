<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Chore Traker Dashboard</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script src="/js/script.js"></script>	
</head>
<body onload="myFunction()">
	<div class="container info">
		<h2>
			Welcome
			<c:out value="${user.firstName}"></c:out>
		</h2>
		<form id="logoutForm" method="POST" action="/logout">
			<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="submit" value="Logout!" />
		</form>
		
		<div class="topHeader">
			<h2>Your Points <span id="totPoints"><c:out value="${user.totalPoints}"></c:out></span></h2>
			<div id="notifications"></div>
		</div>

		<div class="title">
			<a href="/chores/new" class="btn button_sub">Add A Job</a>
		</div>

		<form method="get" action="/">
		    <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="Search by title" value="${keyword}" aria-label="Search"/>
		    <input class="btn btn-outline-success" type="submit" value="Search" />
		</form>
		<div>
		    Page ${currentPage + 1} of ${totalPages}
		</div>
		
		<div>
		    <c:if test="${currentPage > 0}">
		        <a href="?page=${currentPage - 1}&size=4">Previous</a>
		    </c:if>
		
		    <c:if test="${currentPage + 1 < totalPages}">
		        <a href="?page=${currentPage + 1}&size=4">Next</a>
		    </c:if>
		</div>
		<table class="table table-striped table-bordered border-dark">
			<thead>
				<tr>
					<th>Job</th>
					<th>Location</th>
					<th>Due date</th>
					<th>Points</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="chore" items="${chores.content}">
					<tr>
						<td><c:out value='${chore.title}'></c:out></td>
						<td><c:out value='${chore.location}'></c:out></td>
						<td>${chore.dueDate}</td>
						<td><c:out value='${chore.points}'></c:out></td>
						<td><a href="/chores/${chore.id}">View</a> <a
							href="/chores/addToUser/${chore.id}/add">add</a> <c:if
								test="${user.id == chore.choreCreater.id}">
								<a href="/chores/edit/${chore.id}">edit</a>
								<form action="/chores/${chore.id}" method="post">
									<input type="hidden" name="_method" value="delete"> <input
										type="submit" value="cancel" class="text-start deleteBtn">
								</form>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		

		<table class="table table-striped table-bordered border-dark">
			<thead>
				<tr>
					<th>My Jobs</th>
					<th>Due date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="myChore" items="${myChores}">
					<tr>
						<td><span class="dueDateTitle"><c:out value='${myChore.title}'></c:out></span></td>
						<td><span class="dueDate">${myChore.dueDate}</span></td>
						<td><a href="/chores/${myChore.id}">View</a> 
							<a href="/chores/addPoints/${myChore.id}">Done</a></td>							
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<h2 id="activivteTitle">Your last activites:</h2>
		<div class="log-container">
			<c:forEach var="log" items="${logs}">
				<p style="color: green;"><c:out value="${log}"></c:out><br></p>
			</c:forEach>				
		</div>
		

	</div>
</body>
</html>