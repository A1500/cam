package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealFitApply;

/**
 * @title:IWealFitApplyDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitApplyDao extends BaseCURD<WealFitApply>{
	public void save(List<WealFitApply> list);
	//查询年检或换证信息
	public DataSet queryInfo(ParameterSet pset);
}

