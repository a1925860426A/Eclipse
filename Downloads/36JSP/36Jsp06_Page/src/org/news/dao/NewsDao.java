package org.news.dao;

import java.sql.SQLException;
import java.util.List;

import org.news.entity.News;

public interface NewsDao {
    // 获取所有新闻
    public List<News> getAllnews() throws SQLException;
    // 获取某主题下的所有新闻（根据主题id）
    public List<News> getAllnewsByTID(int Tid) throws SQLException;
    // 获取某主题下的所有新闻（根据主题名称）
    public List<News> getAllnewsByTname(String tname) throws SQLException;
    // 获取某主题下的新闻数量
    public int getNewsCountByTID(int Tid) throws SQLException;
    // 获取某主题下的最新新闻
    public List<News> getLatestNewsByTID(int tid, int limit) throws SQLException;
    // 获取某条新闻
    public News getNewsByNID(int nid) throws SQLException;
    // 删除某条新闻
    public int deleteNews(int nid) throws SQLException;
}