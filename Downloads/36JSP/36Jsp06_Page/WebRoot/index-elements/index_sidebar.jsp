<%@page import="org.news.entity.News"%>
<%@page import="org.news.dao.impl.NewsDaoImpl"%>
<%@page import="org.news.dao.NewsDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <div class="sidebar">
    <h1> <img src="images/title_1.gif" alt="国内新闻" /> </h1>
    <div class="side_list">
      <ul>
      	<%
      		for (News news : list1) {//包含于index.jsp中，引用index.jsp中的list1变量
      	%>
                <li><a href='util/news_control.jsp?opr=readNew&nid=<%=news.getNid() %>'><b><%=news.getNtitle() %></b></a></li>
      	<%  } %>
      </ul>
    </div>
    <h1> <img src="images/title_2.gif" alt="国际新闻" /> </h1>
    <div class="side_list">
      <ul>
      	<% 	
      		for (News news : list2) {//包含于index.jsp中，引用index.jsp中的list2变量
      	%>
                <li><a href='util/news_control.jsp?opr=readNew&nid=<%=news.getNid() %>'><b><%=news.getNtitle() %></b></a></li>
      	<%  } %>
      </ul>
    </div>
    <h1> <img src="images/title_3.gif" alt="娱乐新闻" /> </h1>
    <div class="side_list">
      <ul>
      	<%      	
      		for (News news : list3) {//包含于index.jsp中，引用index.jsp中的list3变量
      	%>      	
                <li><a href='util/news_control.jsp?opr=readNew&nid=<%=news.getNid() %>'><b><%=news.getNtitle() %></b></a></li>
      	<%  } %>
      </ul>
    </div>
  </div>
<%--
	request.removeAttribute("news_in_topic");
--%>
