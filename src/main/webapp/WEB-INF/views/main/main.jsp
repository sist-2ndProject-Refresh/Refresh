<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<title>새로고침 - 아끼고, 나누고, 다시쓰는 곳</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="format-detection" content="telephone=no">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <link rel="icon" href="/images/favicon.png" type="image/png">
  <link rel="stylesheet" href="/css/vendor.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="/style.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Playfair+Display:ital,wght@0,900;1,900&family=Source+Sans+Pro:wght@400;600;700;900&display=swap"
    rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="${main_jsp }"></jsp:include>
<jsp:include page="footer.jsp"></jsp:include>
  <script src="/js/jquery-1.11.0.min.js"></script>
  <script src="/js/plugins.js"></script>
  <script src="/js/script.js"></script>
</body>

</html>