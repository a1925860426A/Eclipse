<%@page import="org.news.dao.NewsDao"%>
<%@page import="org.news.dao.impl.NewsDaoImpl,org.news.entity.*"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%
	NewsDao newsDao = new NewsDaoImpl();
	List<News> list = newsDao.getAllnews();	
	session.setAttribute("list", list);
	response.sendRedirect("../newspages/admin.jsp");
%>

