package com.inspur.cams.bpt.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptCompulsory;


/**
 * @title:IBptCompulsoryDao
 * @description:
 * @author:
 * @since:2011-06-05
 * @version:1.0
*/
 public interface IBptCompulsoryDao extends BaseCURD<BptCompulsory>{
	//public void save(List<BptCompulsory> list);
	 //查询
	 public DataSet queryCompulsory(ParameterSet pSet);
	 //修改查询
	 public DataSet queryUpdateCompulsory(ParameterSet pSet);
}

