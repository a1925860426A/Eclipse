<%@page import="org.news.service.CommentsService"%>
<%@page import="org.news.service.impl.CommentsServiceImpl"%>
<%@page import="org.news.service.NewsService"%>
<%@page import="org.news.service.impl.NewsServiceImpl"%>
<%@page import="org.news.service.TopicsService"%>
<%@page import="org.news.service.impl.TopicsServiceImpl"%>
<%@page import="org.news.entity.*"%>
<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
    String opr = request.getParameter("opr");
    TopicsService topicService = new TopicsServiceImpl();
    NewsService newsService = new NewsServiceImpl();
    CommentsService commentsService = new CommentsServiceImpl();

    if (opr.equals("addComment")) {//添加评论
        String cauthor = request.getParameter("cauthor");
        String cnid = request.getParameter("nid");
        String cip = request.getParameter("cip");
        String ccontent = request.getParameter("ccontent");
        Comment comment = new Comment();
        comment.setCnid(Integer.parseInt(cnid));
        comment.setCcontent(ccontent);
        comment.setCdate(new java.util.Date());
        comment.setCip(cip);
        comment.setCauthor(cauthor);
        try {
            commentsService.addComment(comment);
            out.print("<script type=\"text/javascript\">");
            out.print("alert(\"评论成功，点击确认返回原来页面\");");
            out.print("location.href=\"../util/news_control.jsp?opr=readNew&nid="
                    + cnid + "\";");
            out.print("</script>");
        } catch (Exception e) {
            out.print("<script type=\"text/javascript\">");
            out.print("alert(\"评论添加失败！请联系管理员查找原因！点击确认返回原来页面\");");
            out.print("location.href=\"../util/news_control.jsp?opr=readNew&nid="
                    + cnid + "\";");
            out.print("</script>");
        }
    } else if ("readNew".equals(opr)) {//读取某条新闻
        String nid = request.getParameter("nid");
        News news = newsService.findNewsByNid(Integer.parseInt(nid));
        news.setComments(commentsService.findCommentsByNid(Integer
                .parseInt(nid)));
        Map<Integer, Integer> topics = new HashMap<Integer, Integer>();
        topics.put(1, 5);
        topics.put(2, 5);
        topics.put(5, 5);
        List<List<News>> latests = newsService
                .findLatestNewsByTid(topics);
        request.setAttribute("news", news);
        request.setAttribute("list1", latests.get(0));//左侧国内新闻
        request.setAttribute("list2", latests.get(1));//左侧国际新闻
        request.setAttribute("list3", latests.get(2));//左侧娱乐新闻
        request.getRequestDispatcher("/newspages/news_read.jsp")
                .forward(request, response);
    } else if ("listTitle".equals(opr)) {
        Map<Integer, Integer> topics = new HashMap<Integer, Integer>();
        topics.put(1, 5);
        topics.put(2, 5);
        topics.put(5, 5);
        List<List<News>> latests = newsService
                .findLatestNewsByTid(topics);
        List<Topic> list = topicService.findAllTopics();
        List<News> list4 = null;
        String tid = request.getParameter("tid");
        if (tid == null || (tid = tid.trim()).length() == 0)
            list4 = newsService.findAllNews(); //查询全部新闻
        else
            // 查询指定主题下的新闻
            list4 = newsService.findAllNewsByTid(Integer.parseInt(tid));
        request.setAttribute("list1", latests.get(0));//左侧国内新闻
        request.setAttribute("list2", latests.get(1));//左侧国际新闻
        request.setAttribute("list3", latests.get(2));//左侧娱乐新闻
        request.setAttribute("list", list); //所有的主题
        request.setAttribute("list4", list4);//中间的新闻
        request.getRequestDispatcher("/index.jsp").forward(request,
                response);
    } else if ("list".equals(opr)) {//编辑新闻时对新闻的查找
        List<News> list = newsService.findAllNews();
        session.setAttribute("list", list);
        response.sendRedirect("../newspages/admin.jsp");
    } else if ("delete".equals(opr)) { // 删除新闻及评论
        String nid = request.getParameter("nid");
        try {
            int result = newsService.deleteNews(Integer
                    .parseInt(nid));
            if (result == 0) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"未找到相关新闻，点击确认返回新闻列表\");");
                out.print("location.href=\"news_control.jsp?opr=list\";");
                out.print("</script>");
            } else {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"已经成功删除新闻，点击确认返回新闻列表\");");
                out.print("location.href=\"news_control.jsp?opr=list\";");
                out.print("</script>");
            }
        } catch (Exception e) {
            out.print("<script type=\"text/javascript\">");
            out.print("alert(\"删除失败，请联系管理员！点击确认返回新闻列表\");");
            out.print("location.href=\"news_control.jsp?opr=list\";");
            out.print("</script>");
        }
    }
%>

