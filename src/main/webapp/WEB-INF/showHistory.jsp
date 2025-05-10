<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User Job History</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script src="/js/script.js"></script>
</head>
<body>
	<div class="container info">
		<div class="actions navbar-expand navbar-dark bg-dark">		
			<img alt="Chore Tracker" src="/img/choreTracker.png" width="200px" height="60px">
			<div class="nav-actions">
				<a href="/" class="btn btn-outline-light">Back</a>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!"  class="btn btn-outline-light" />
				</form>
				
			</div>			
		</div>
		<div class="main">
			<h1><c:out value="${choreUser.firstName}"></c:out>'s History</h1>
			
			<div class="d-flex justify-content-between align-items-center my-3">
				<div class="fs-5">
					<span class="badge bg-info text-dark"> Page ${currentPageDoneChores + 1} of ${totalPagesDoneChores} </span>
				</div>

				<nav>
					<ul class="pagination mb-0">
						<c:if test="${currentPageDoneChores > 0}">
							<li class="page-item"><a class="page-link"
								href="?page=${currentPageDoneChores - 1}&size=4" aria-label="Previous">
									<span aria-hidden="true">&laquo; Previous</span>
							</a></li>
						</c:if>

						<c:if test="${currentPageDoneChores + 1 < totalPagesDoneChores}">
							<li class="page-item"><a class="page-link"
								href="?page=${currentPageDoneChores + 1}&size=4" aria-label="Next"> <span
									aria-hidden="true">Next &raquo;</span>
							</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
			<table class="table table-striped table-bordered border-dark">
				<thead>
					<tr>
						<th>Chore</th>
						<th>Points</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="doneChore" items="${allDoneChores.content}">
						<tr>
							<td><c:out value='${doneChore.title}'></c:out></td>
							<td><c:out value='${doneChore.points}'></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>