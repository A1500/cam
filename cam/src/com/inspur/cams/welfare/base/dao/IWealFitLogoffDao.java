package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.welfare.base.data.WealFitLogoff;

/**
 * @title:IWealFitLogoffDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitLogoffDao extends BaseCURD<WealFitLogoff>{
	public void save(List<WealFitLogoff> list);
}

