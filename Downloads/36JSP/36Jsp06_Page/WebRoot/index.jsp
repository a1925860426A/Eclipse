<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.news.entity.Topic"%>
<%@page import="org.news.entity.News"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%  List<News> list1 = (List<News>) request.getAttribute("list1");
    List<News> list2 = (List<News>) request.getAttribute("list2");
    List<News> list3 = (List<News>) request.getAttribute("list3");
    List<Topic> list = (List<Topic>) request.getAttribute("list");
    List<News> list4 = (List<News>) request.getAttribute("list4");
    if (list1 == null && list2 == null && list3 == null) {
        request.getRequestDispatcher("/util/news_control.jsp?opr=listTitle")
                .forward(request, response);
        return;
    }%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻中国</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	function check(){
		var login_username = document.getElementById("uname");
		var login_password = document.getElementById("upwd");
		if(login_username.value == ""){
			alert("用户名不能为空！请重新填入！");
			login_username.focus();	
			return false;
		}else if(login_password.value == ""){
			alert("密码不能为空！请重新填入！");
			login_password.focus();
			return false;
		}
		return true;
	}
	
	function focusOnLogin(){
		var login_username = document.getElementById("uname");
		login_username.focus();	
	}
</script>
</head>

<body onload="focusOnLogin()">
  
<div id="header">
  <div id="top_login">
    <form action="util/do_login.jsp" method="post" onsubmit="return check()">
      <label> 登录名 </label>
      <input type="text" name="uname" value="" class="login_input" />
      <label> 密&#160;&#160;码 </label>
      <input type="password" name="upwd" value="" class="login_input" />
      <input type="submit" class="login_sub" value="登录" />
      <label id="error"> </label>
      <img src="images/friend_logo.gif" alt="Google" id="friend_logo" />
    </form>
  </div>
  <div id="nav">
    <div id="logo"> <img src="images/logo.jpg" alt="新闻中国" /> </div>
    <div id="a_b01"> <img src="images/a_b01.gif" alt="" /> </div>
    <!--mainnav end-->
  </div>
</div>
<div id="container">

<%@include file="index-elements/index_sidebar.jsp"%>
 
  <div class="main">
    <div class="class_type"> <img src="images/class_type.gif" alt="新闻中心" /> </div>
    <div class="content">
      <ul class="class_date">
      <%
      int n=0;
      for (Topic topic : list) {
          n++;
          if (n % 11 == 1) { out.println("<li id='class_month'>"); }
          %>
          <a href=
          "util/news_control.jsp?opr=listTitle&tid=<%=topic.getTid() %>">
          <b><%=topic.getTname() %></b></a>
          <%
          if (n % 11 == 0) { out.println("</li>"); }
      } 
      if (n % 11 != 0) { out.println("</li>"); }%>
      </ul>
      <ul class="classlist">
      <%
      if (list4 == null) { out.println("<h6>出现错误，请稍后再试或与管理员联系</h6>"); }
      else if (list4.size() == 0) { out.println("<h6>抱歉，没有找到相关的新闻</h6>"); }
      else {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        n = 0;
        for (News news : list4) { %>
          <li>
            <a href='util/news_control.jsp?opr=readNew&nid=<%=news.getNid() %>'>
                <%=news.getNtitle() %></a>
            <span><%=df.format(news.getNcreatedate()) %></span>
          </li>
      <%  n++;
          if (n % 5 == 0) { out.println("<li class='space'></li>"); }
        }
      } %><p align="right"> 当前页数:[1/2]&nbsp; <a href="#">下一页</a> <a href="#">末页</a> </p>
      </ul>
    </div>
    <%@include file="index-elements/index_rightbar.html"%>
  </div>
</div>
  <%@include file="index-elements/index_bottom.html"%>
</body>
</html>