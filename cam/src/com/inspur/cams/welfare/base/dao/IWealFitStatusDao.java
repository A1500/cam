package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealFitStatus;

/**
 * @title:IWealFitStatusDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitStatusDao extends BaseCURD<WealFitStatus>{
	public void save(List<WealFitStatus> list);
	
	//假肢装配企业基本信息查询
	 public DataSet queryInfoBySql(ParameterSet pset);
}

