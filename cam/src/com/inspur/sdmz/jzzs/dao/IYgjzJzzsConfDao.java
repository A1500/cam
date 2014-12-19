package com.inspur.sdmz.jzzs.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jzzs.data.YgjzJzzsConf;

/**
 * @title:IYgjzJzzsConfDao
 * @description:
 * @author:
 * @since:2011-05-14
 * @version:1.0
*/
 public interface IYgjzJzzsConfDao extends BaseCURD<YgjzJzzsConf>{
	public void save(List<YgjzJzzsConf> list);
}

