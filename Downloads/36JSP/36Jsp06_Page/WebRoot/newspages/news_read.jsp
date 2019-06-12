<%@page import="org.news.entity.Comment"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
<link href="css/read.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	  		function check(){
	  			var cauthor = document.getElementById("cauthor");
	  			var content = document.getElementById("ccontent");
	  			if(cauthor.value == ""){
	  				alert("用户名不能为空！！");
	  				return false;
	  			}else if(content.value == ""){
	  				alert("评论内容不能为空！！");
	  				return false;
	  			}
	  			return true;
	  		}
	  	</script>
</head>
<body>
<div id="header">
  <div id="top_login">
    <label> 登录名 </label>
    <input type="text" id="uname" value="" class="login_input" />
    <label> 密&#160;&#160;码 </label>
    <input type="password" id="upwd" value="" class="login_input" />
    <input type="button" class="login_sub" value="登录" onclick="login()"/>
    <label id="error"> </label>
    <a href="index.jsp" class="login_link">返回首页</a> <img src="images/friend_logo.gif" alt="Google" id="friend_logo" /> </div>
  <div id="nav">
    <div id="logo"> <img src="images/logo.jpg" alt="新闻中国" /> </div>
    <div id="a_b01"> <img src="images/a_b01.gif" alt="" /> </div>
    <!--mainnav end-->
  </div>
</div>
<%
    News n = (News) request.getAttribute("news");
    List<Comment> comments= (List<Comment>) n.getComments();
    List<News> list1 = (List<News>) request.getAttribute("list1");
    List<News> list2 = (List<News>) request.getAttribute("list2");
    List<News> list3 = (List<News>) request.getAttribute("list3");      
%>
<div id="container">
  <%@ include file="../index-elements/index_sidebar.jsp" %>
    <div class="main">
    <div class="class_type"> <img src="images/class_type.gif" alt="新闻中心" /> </div>
    <div class="content">
      <ul class="classlist">
        <table width="80%" align="center">
          <tr width="100%">
            <td colspan="2" align="center"><%=n.getNtitle() %></td>
          </tr>
          <tr>
            <td colspan="2"><hr />
            </td>
          </tr>
          <tr>
            <td align="center">作者：<%=n.getNauthor() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td align="left">发布时间：<%=n.getNcreatedate() %></td>
          </tr>          
          <tr>
            <td colspan="2" align="center"></td>
          </tr>
          <tr>
            <td colspan="2"><%=n.getNcontent() %></td>
          </tr>
          <tr>
            <td colspan="2"><hr />
            </td>
          </tr>
        </table>
      </ul>
      <ul class="classlist">
        <table width="80%" align="center">
        
        <%
        if (comments.size() <= 0) {%>
            <tr><td colspan="6"> 暂无评论！ </td></tr>
            <tr>
                <td colspan="6"><hr />
                </td>
            </tr>
        <%} else {
            for (Comment comment : comments) { %>
                <tr>
                    <td> 留言人： </td>
                    <td><%=comment.getCauthor()%></td>
                    <td> IP： </td>
                    <td><%=comment.getCip()%></td>
                    <td> 留言时间： </td>
                    <td><%=comment.getCdate()%></td>
                </tr>
                <tr>
                    <td colspan="6"><%=comment.getCcontent()%></td>
                </tr>
                <tr>
                    <td colspan="6"><hr />
                    </td>
                </tr>
        <%   }
         }        
         %>
        </table>
      </ul>
      <ul class="classlist">
        <form action="util/news_control.jsp?opr=addComment" method="post" onSubmit="return checkComment()">
          <input type="hidden" name="nid" value="<%=n.getNid() %>" />
          <table width="80%" align="center">
            <tr>
              <td> 评 论 </td>
            </tr>
            <tr>
              <td> 用户名： </td>
              <td>
                  <%if(session.getAttribute("admin")!=null&&session.getAttribute("admin").toString().length()>0){%>
                  <input id="cauthor" name="cauthor" value="<%=session.getAttribute("admin") %>" readonly="readonly" style="border:0px;"/>
                  <%}else{%>
                  <input id="cauthor" name="cauthor" value="这家伙很懒什么也没留下"/>
                  <%} %> 
                IP：
                <input name="cip" id="cip" value="<%=request.getRemoteAddr() %>" readonly="readonly" style="border:0px;"/>
              </td>
            </tr>
            <tr>
              <td colspan="2"><textarea name="ccontent" id="ccontent" cols="70" rows="10"></textarea>
              </td>
            </tr>
            <tr><td><input name="submit" value="发  表" type="submit"/>
              </td></tr>
          </table>
        </form>
      </ul>
    </div>
  </div>
</div>
<%--
    request.removeAttribute("news_view");
    request.removeAttribute("comments_view");
--%>
<%@include file="../index-elements/index_bottom.html"%>
</body>
</html>
