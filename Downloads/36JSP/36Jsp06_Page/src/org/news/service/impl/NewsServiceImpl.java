package org.news.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.news.dao.NewsDao;
import org.news.dao.impl.CommentsDaoImpl;
import org.news.dao.impl.NewsDaoImpl;
import org.news.entity.News;
import org.news.service.NewsService;
import org.news.util.DatabaseUtil;

public class NewsServiceImpl implements NewsService {

    @Override
    public List<News> findAllNews() throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();

            return new NewsDaoImpl(conn).getAllnews();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
    }

    @Override
    public List<News> findAllNewsByTid(int tid) throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();

            return new NewsDaoImpl(conn).getAllnewsByTID(tid);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
    }

    @Override
    public List<News> findAllNewsByTname(String tname) throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();

            return new NewsDaoImpl(conn).getAllnewsByTname(tname);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
    }

    @Override
    public List<News> findLatestNewsByTid(int tid, int limit)
            throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();

            return new NewsDaoImpl(conn).getLatestNewsByTID(tid, limit);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
    }

    @Override
    public List<List<News>> findLatestNewsByTid(Map<Integer, Integer> topicsMap)
            throws SQLException {
        Connection conn = null;
        try {
            List<List<News>> result = null;
            if (topicsMap != null && topicsMap.size() != 0) {
                conn = DatabaseUtil.getConnection();
                NewsDao newsDao = new NewsDaoImpl(conn);

                result = new ArrayList<List<News>>();
                Iterator<Entry<Integer, Integer>> topics = topicsMap.entrySet()
                        .iterator();
                while (topics.hasNext()) {
                    Entry<Integer, Integer> oneTopic = topics.next();
                    result.add(newsDao.getLatestNewsByTID(oneTopic.getKey(),
                            oneTopic.getValue()));
                }
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
    }

    @Override
    public News findNewsByNid(int nid) throws SQLException {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();

            return new NewsDaoImpl(conn).getNewsByNID(nid);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
    }

    @Override
    public int deleteNews(int nid) throws SQLException {
        Connection conn = null;
        int result;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);
            // 删除相关评论
            new CommentsDaoImpl(conn).deleteCommentsByNid(nid);
            // 删除新闻
            result = new NewsDaoImpl(conn).deleteNews(nid);
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null)
                try {
                    conn.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            throw e;
        } finally {
            DatabaseUtil.closeAll(conn, null, null);
        }
        return result;
    }

}
