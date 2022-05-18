package org.zdd.bookstore.model.dao;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;

import java.io.IOException;
import java.net.URI;
import java.util.Properties;

public class HDFSDao {

    static FileSystem fileSystem;
    static Properties properties;

    static {

        properties = new Properties();
        try {
            properties.load(HDFSDao.class.getClassLoader().getResourceAsStream("application.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        Configuration conf = new Configuration();
        conf.set("dfs.client.block.write.replace-datanode-on-failure.enable", "true");
        conf.set("dfs.client.block.write.replace-datanode-on-failure.policy", "NEVER");
        conf.set("dfs.client.use.datanode.hostname","true");
        try {
            fileSystem = FileSystem.get(URI.create(properties.getProperty("spring.hdfs.url")), conf, "root");
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static  Properties getProperties() {
        return properties;
    }

    public static FileSystem getFileSystem() {
        return fileSystem;
    }
}
