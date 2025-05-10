<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chore Traker Dashboard</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">

</head>
<body onload="myFunction()">
	<div class="container info">
		<div class="actions navbar-expand navbar-dark bg-dark">		
			<img alt="Chore Tracker" src="/img/choreTracker.png" width="200px" height="60px">
			
			<div class="nav-actions">
				<span class="fa-layers fa-fw"> <a href="/seeArchive"><i
						class="fa fa-archive icon-btn" aria-hidden="true"></i></a>
				</span>
				<div>
					<span class="fa-layers fa-fw"> 
						<c:if test="${myCommentsSize == 0}">
							<i class="fas fa-bell icon-btn" onclick="showPopup()"></i> 
						</c:if>
						<c:if test="${myCommentsSize != 0}">
							<i class="fas fa-bell icon-btn" style="color: red;" onclick="showPopup()"></i> 
						</c:if>
						<span class="fa-layers-counter">${myCommentsSize}</span>
					</span>`
				</div>
				<a href="/showProfile/${user.id}" class="btn btn-outline-light">Profile</a>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!"
						 class="btn btn-outline-light"/>
				</form>
			</div>

		</div>

		<div class="main">
		
		<h1> Welcome <c:out value="${user.firstName}"></c:out> </h1>
			
			<div id="popupBox" class="popupBox" style="display: none;">
				<form:form method="get" action="/inArchive" modelAttribute="myComments">
					<input type="submit" value="x" class="btn btn-outline-info" data-bs-dismiss="alert" onclick="closePopup()">
				</form:form>
				<br>
				<c:if test="${myCommentsSize == 0}">
					<p class="alert alert-warning">You don't have any new comment, See archive for your old comments</p>
				</c:if>
				<c:if test="${myCommentsSize > 0}">
					<c:forEach var="myComment" items="${myComments}">
						<p class="alert alert-primary">
							<c:out value="${myComment.commentText}" />
						</p>
					</c:forEach>
				</c:if>
			</div>

			<div class="topHeader">
				<h2>
					Your Points:
					<span id="totPoints">
						<c:if test="${user.totalPoints > 20}">
							<span style="color: #24c98d; font-size: 45px;"><c:out value="${user.totalPoints}"></c:out></span>
						</c:if>
						<c:if test="${user.totalPoints < 20}">
							<span style="color: #e33f0e; font-size: 45px;"><c:out value="${user.totalPoints}"></c:out></span>
						</c:if>
					</span>
				</h2>
				<div id="notifications"></div>
			</div>

			<div class="title">
				<a href="/chores/new" class="btn button_sub">Add A Job</a>
			</div>

			<form method="get" action="/" class="searchJob">
				<input class="form-control mr-sm-2" type="search" name="keyword" placeholder="Search by title" value="${keyword}"
					aria-label="Search" /> 
					<input class="btn btn-outline-success" type="submit" value="Search" />
			</form>

			<div class="d-flex justify-content-between align-items-center my-3">
				<div class="fs-5">
					<span class="badge bg-info text-dark"> Page ${currentPage + 1}
						of ${totalPages} </span>
				</div>

				<nav>
					<ul class="pagination mb-0">
						<c:if test="${currentPage > 0}">
							<li class="page-item"><a class="page-link"
								href="?page=${currentPage - 1}&size=4" aria-label="Previous">
									<span aria-hidden="true">&laquo; Previous</span>
							</a></li>
						</c:if>

						<c:if test="${currentPage + 1 < totalPages}">
							<li class="page-item"><a class="page-link"
								href="?page=${currentPage + 1}&size=4" aria-label="Next"> <span
									aria-hidden="true">Next &raquo;</span>
							</a></li>
						</c:if>
					</ul>
				</nav>
			</div>

			<table class="table table-striped table-bordered border-dark">
				<thead>
					<tr>
						<th>Job</th>
						<th>Difficulty</th>
						<th>Due date</th>
						<th>Points</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="chore" items="${chores.content}">
						<tr>
							<td><c:out value='${chore.title}'></c:out></td>
							<td><c:if test="${chore.difficulty == 'Easy'}">
									<span class="text-success"><c:out
											value='${chore.difficulty}'></c:out></span>
								</c:if> <c:if test="${chore.difficulty == 'Medium'}">
									<span class="text-warning"><c:out
											value='${chore.difficulty}'></c:out></span>
								</c:if> <c:if test="${chore.difficulty == 'Hard'}">
									<span class="text-danger"><c:out
											value='${chore.difficulty}'></c:out></span>
								</c:if></td>
							<td>${chore.dueDate}</td>
							<td><c:out value='${chore.points}'></c:out></td>
							<td><a href="/chores/${chore.id}">View</a> <a
								href="/chores/addToUser/${chore.id}/add">add</a> <c:if
									test="${user.id == chore.choreCreater.id}">
									<a href="/chores/edit/${chore.id}">edit</a>
									<a href="/delete/${chore.id}"> cancel </a>
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="main">
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
							<td><span class="dueDateTitle"><c:out
										value='${myChore.title}'></c:out></span></td>
							<td><span class="dueDate">${myChore.dueDate}</span></td>
							<td><a href="/chores/${myChore.id}">View</a> <c:if
									test="${totalSubChoreCount[myChore.id] == doneSubChoreCount[myChore.id]}">
									<a href="/chores/addPoints/${myChore.id}"
										onclick="isCongra(${myChore.points},${user.totalPoints})">Done</a>
								</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="main">
			<h2 id="activivteTitle">Your last activites:</h2>
			<div class="log-container">
				<c:forEach var="log" items="${logs}">
					<p style="color: green;">
						<c:out value="${log}"></c:out>
						<br>
					</p>
				</c:forEach>
			</div>
		</div>
	</div>
	<script src="/js/script.js"></script>
</body>
</html>