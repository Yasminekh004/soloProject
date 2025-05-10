<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<title>Admin Dashboard</title>
</head>
<body>
	<div class="container info">
		<div class="actions navbar-expand navbar-dark bg-dark">		
			<img alt="Chore Tracker" src="/img/choreTracker.png" width="200px" height="60px">						
			<div class="nav-actions">			
				<a href="/chores/new" class="btn btn-outline-light">Add A Job</a>
				<a href="/showProfile/${currentUser.id}" class="btn btn-outline-light">Profile</a>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="submit" value="Logout!" class="btn btn-outline-light"/>
				</form>
			</div>
		</div>


		<div class="main">
		
		<h1>Welcome, ${currentUser.firstName}</h1>
		
			<div class="d-flex justify-content-between align-items-center my-3">
			  <div class="fs-5">
			    <span class="badge bg-info text-dark">
			      Page ${currentPage + 1} of ${totalPages}
			    </span>
			  </div>
			
			  <nav>
			    <ul class="pagination mb-0">
			      <c:if test="${currentPage > 0}">
			        <li class="page-item">
			          <a class="page-link" href="?page=${currentPage - 1}&size=4" aria-label="Previous">
			            <span aria-hidden="true">&laquo; Previous</span>
			          </a>
			        </li>
			      </c:if>
			
			      <c:if test="${currentPage + 1 < totalPages}">
			        <li class="page-item">
			          <a class="page-link" href="?page=${currentPage + 1}&size=4" aria-label="Next">
			            <span aria-hidden="true">Next &raquo;</span>
			          </a>
			        </li>
			      </c:if>
			    </ul>
			  </nav>
			</div>
			
			<table class="table table-bordered border-dark">
				<thead>
					<tr>
						<th>Username</th>
						<th>Total Points</th>
						<th>Score</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="user" items="${users.content}">
						<c:if test="${!user.roles.get(0).name.contains('ROLE_ADMIN')}">
							<tr>
								<td><a href="/user/${user.id}">${user.firstName} ${user.lastName}</a></td>
								<td><a href="/showHistroy/${user.id}">${user.totalPoints}</a></td>
								<td>
									<c:if test="${user.totalPoints == 0}">
										<i class="fa-solid fa-star" style="color: grey;"></i>
									</c:if>
									<c:if test="${user.totalPoints > 0 && user.totalPoints < 20}">
										<i class="fa-solid fa-star" style="color: yellow;"></i>
									</c:if>
									<c:if test="${user.totalPoints > 20 && user.totalPoints < 100}">
										<i class="fa-solid fa-star" style="color: yellow;"></i>
										<i class="fa-solid fa-star" style="color: yellow;"></i>
									</c:if>
									<c:if test="${user.totalPoints > 100}">
										<i class="fa-solid fa-star" style="color: yellow;"></i>
										<i class="fa-solid fa-star" style="color: yellow;"></i>
										<i class="fa-solid fa-star" style="color: yellow;"></i>
									</c:if>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
</body>
</html>