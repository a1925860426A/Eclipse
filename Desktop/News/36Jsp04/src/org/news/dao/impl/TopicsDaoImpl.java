package org.news.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.news.dao.BaseDao;
import org.news.dao.TopicsDao;
import org.news.entity.Topic;

public class TopicsDaoImpl extends BaseDao implements TopicsDao {

    public List<Topic> getAllTopics() {
        List<Topic> list = new ArrayList<Topic>();
        ResultSet rs = null;//空的数据集
        // 获取所有主题
        String sql = "select * from topic";//查询所有的主题
        try {
            rs = executeQuery(sql);//把查询到的内容全部存储到空的数据集里面
            Topic topic = null;
            while (rs.next()) {
                topic = new Topic();//创建一个Topic用来获取id和name
                topic.setTid(rs.getInt("tid"));//用TopicGet方法获取id
                topic.setTname(rs.getString("tname"));//用TopicGet方法获取name
                list.add(topic);//把topic存到list空的数据集里面
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeAll(conn, null, rs);//关闭所有链接
        }
        return list;//返回一个list集合
    }

    public int deleteTopic(int tid) {
        String sql = "DELETE FROM `TOPIC` WHERE `tid` = ?";
        int result = 0;
        try {
            result = executeUpdate(sql, tid);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeAll(conn, null, null);
        }
        return result;
    }

    public int updateTopic(Topic topic) {
        String sql = "UPDATE `TOPIC` SET `tname` = ? WHERE `tid` = ?";
        int result = 0;
        try {
            result = executeUpdate(sql, topic.getTname(), topic.getTid());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeAll(conn, null, null);
        }
        return result;
    }

    public Topic findTopicByName(String name) {
        String sql = "select * from topic where tname=?";
        ResultSet rs = null;
        Topic topic = null;
        try {
            rs = executeQuery(sql, name);
            if (rs.next()) {
                topic = new Topic();
                topic.setTid(rs.getInt("tid"));
                topic.setTname(rs.getString("tname"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeAll(conn, null, rs);
        }
        return topic;
    }

    public int addTopic(String name) {
        String sql = "insert into topic(TNAME) values(?)";
        int result = 0;
        try {
            result = executeUpdate(sql, name);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeAll(conn, null, null);
        }
        return result;
    }
}
