<%@page import="org.news.service.UserService"%>
<%@page import="org.news.service.impl.UserServiceImpl"%>
<%@page import="org.news.entity.User"%>
<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="utf-8"%>
<%
    String uname = request.getParameter("uname");
    String password = request.getParameter("upwd");
    UserService userService = new UserServiceImpl();

    User user = new User();
    user.setUname(uname);
    user.setUpwd(password);
    user = userService.doLogin(user);
    if (user == null) {
        out.print("<script type=\"text/javascript\">");
        out.print("alert(\"用户名密码错误，请重新登录\");");
        out.print("open(\"../index.jsp\",\"_self\");");
        out.print("</script>");
    } else {
        session.setAttribute("admin", uname);
        response.sendRedirect("../util/news_control.jsp?opr=list");
    }
%>
