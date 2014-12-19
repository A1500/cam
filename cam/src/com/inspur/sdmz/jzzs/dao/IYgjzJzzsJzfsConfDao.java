package com.inspur.sdmz.jzzs.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jzzs.data.YgjzJzzsJzfsConf;

/**
 * @title:IYgjzJzzsJzfsConfDao
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
 public interface IYgjzJzzsJzfsConfDao extends BaseCURD<YgjzJzzsJzfsConf>{
	public void save(List<YgjzJzzsJzfsConf> list);
}

