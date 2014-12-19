package com.inspur.cams.comm.subsys.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.subsys.data.ComSubsysConfig;

/**
 * @title:IComSubsysConfigDao
 * @description:
 * @author:
 * @since:2012-01-17
 * @version:1.0
*/
 public interface IComSubsysConfigDao extends BaseCURD<ComSubsysConfig>{
	public void save(List<ComSubsysConfig> list);
}

