package org.zdd.bookstore.model.service.impl;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.springframework.stereotype.Service;
import org.zdd.bookstore.common.utils.TimeUtils;
import org.zdd.bookstore.model.dao.HDFSDao;
import org.zdd.bookstore.model.service.HDFSService;

import java.io.IOException;
import java.util.Properties;

@Service
public class HDFSServiceImpl implements HDFSService {

    @Override
    public void logToHDFS(String line) {

        FileSystem fileSystem = HDFSDao.getFileSystem();
        Properties properties = HDFSDao.getProperties();

        try {
            String path =  properties.getProperty("spring.hdfs.shoppingLog") + TimeUtils.getHDFSTimes() + ".log";

            FSDataOutputStream outputStream = null;

            if(fileSystem.exists(new Path(path))){

                outputStream = fileSystem.append(new Path(path));

            }else {

                outputStream = fileSystem.create(new Path(path));
            }

            Configuration conf = new Configuration();
            conf.set("dfs.client.block.write.replace-datanode-on-failure.enable", "true");
            conf.set("dfs.client.block.write.replace-datanode-on-failure.policy", "NEVER");

            IOUtils.copyBytes(org.apache.commons.io.IOUtils.toInputStream(line + "\r\n"),outputStream,conf,true);

            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
