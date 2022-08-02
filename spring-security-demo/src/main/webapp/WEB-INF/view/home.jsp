<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
	HOME IS WHERE IT HURTS ___________ / \ | | | | | | | | \ / \
	____________/

	<hr>
	<!-- afficher nom du'utilisateur et rôle -->
	<p>
		Utilisateur :
		<security:authentication property="principal.username" />
	</p>
	<p>
		Roles(s) :
		<security:authentication property="principal.authorities" />
		<!-- authorities est équivalent au rôle -->
	</p>
	<hr>

	<security:authorize access="hasRole('MANAGER')">
		<!-- page "/managers" réservée aux managers -->
		<p>
			<a href="${pageContext.request.contextPath}/managers">Réunion
				managers</a> (Réservé aux managers)
		</p>
		</security:authorize>
		
		<!-- page "/admins" réservée aux admins -->
		<security:authorize access="hasRole('ADMIN')">
		<p>
			<a href="${pageContext.request.contextPath}/admins">Réunion
				admins</a> (Réservé aux admins)
		</p>
	</security:authorize>

	<!-- Ajout du bouton logout -->
	<form:form action="${pageContext.request.contextPath}/logout"
		method="POST">
		<input type="submit" value="Se déconnecter" />
	</form:form>

</body>
</html>