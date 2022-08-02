<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/css/style.css" />

<title>Page login</title>
</head>
<body>
	<h3>Ma page de login custom</h3>
	<form:form
		action="${pageContext.request.contextPath}/authenticateLogin"
		method="POST">
		<c:if test="${param.error != null }">
			<i class="failed">NOM D'UTILISATEUR / MOT DE PASSE INVALIDE</i>
		</c:if>
		<!-- checker le logout -->
		<c:if test="${param.logout != null}">
			<i class="logout">Vous avez été déconnecté.</i>
		</c:if>
		<p>
			Nom utilisateur : <input type="text" name="username" />
		</p>
		<p>
			Mot de passe : <input type="password" name="password" />
		</p>
		<input type="submit" value="Login" />
	</form:form>
</body>
</html>