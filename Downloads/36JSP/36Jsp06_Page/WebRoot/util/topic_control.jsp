<%@page import="org.news.service.TopicsService"%>
<%@page import="org.news.service.impl.TopicsServiceImpl"%>
<%@page import="org.news.entity.Topic"%>
<%@page language="java" import="java.util.*,java.sql.*"
	pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
    String opr = request.getParameter("opr");
    TopicsService topicsService = new TopicsServiceImpl();

    if ("del".equals(opr)) { //删除主题
        String tid = request.getParameter("tid");
        try {
            int result = topicsService.deleteTopic(Integer
                    .parseInt(tid));
            if (result == -1) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"该主题下还有文章，不能删除！\");");
                out.print("location.href=\"topic_control.jsp?opr=list\";");
                out.print("</script>");
            } else if (result == 0) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"未找到相关主题，点击确认返回主题列表\");");
                out.print("location.href=\"topic_control.jsp?opr=list\";");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"已经成功删除主题，点击确认返回主题列表\");");
                out.print("location.href=\"topic_control.jsp?opr=list\";");
                out.print("</script>");
            }
        } catch (Exception e) {
            out.print("<script type=\"text/javascript\">");
            out.print("alert(\"删除失败，请联系管理员！点击确认返回主题列表\");");
            out.print("location.href=\"topic_control.jsp?opr=list\";");
            out.print("</script>");
        }
    } else if ("update".equals(opr)) { //更新主题
        String tid = request.getParameter("tid");
        String tname = request.getParameter("tname");
        Topic topic = new Topic();
        topic.setTid(Integer.parseInt(tid));
        topic.setTname(tname);
        try {
            int result = topicsService.updateTopic(topic);
            if (result == -1) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"当前主题已存在，请输入不同的主题！\");");
                out.print("location.href=\"../newspages/topic_modify.jsp?tid="
                        + tid + "&tname=" + tname + "\";");
                out.print("</script>");
            } else if (result == 0) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"未找到相关主题，点击确认返回主题列表\");");
                out.print("location.href=\"topic_control.jsp?opr=list\";");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"已经成功更新主题，点击确认返回主题列表\");");
                out.print("location.href=\"topic_control.jsp?opr=list\";");
                out.print("</script>");
            }
        } catch (Exception e) {
            out.print("<script type=\"text/javascript\">");
            out.print("alert(\"更新失败，请联系管理员！点击确认返回主题列表\");");
            out.print("location.href=\"topic_control.jsp?opr=list\";");
            out.print("</script>");
        }
    } else if (opr.equals("list")) {
        List<Topic> list = topicsService.findAllTopics();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/newspages/topic_list.jsp")
                .forward(request, response);
    } else if (opr.equals("add")) {//添加主题
        String tname = request.getParameter("tname");
        try {
            int result = topicsService.addTopic(tname);
            if (result == -1) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"当前主题已存在，请输入不同的主题！\");");
                out.print("location.href=\"../newspages/topic_add.jsp\";");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"主题创建成功，点击确认返回主题列表！\");");
                out.print("location.href=\"topic_control.jsp?opr=list\";");
                out.print("</script>");
            }
        } catch (Exception e) {
            out.print("<script type=\"text/javascript\">");
            out.print("alert(\"添加失败，请联系管理员！点击确认返回主题列表\");");
            out.print("location.href=\"topic_control.jsp?opr=list\";");
            out.print("</script>");
        }
    }
%>
