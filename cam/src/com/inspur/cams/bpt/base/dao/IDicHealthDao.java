package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.cams.bpt.base.data.DicHealth;

/**
 * @title:IDicHealthDao
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public interface IDicHealthDao extends BaseCURD<DicHealth>{
	public void save(List<DicHealth> list);
	
	public DataSet getAllWaraData();
}

