package com.inspur.cams.bpt.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

import com.inspur.cams.bpt.base.dao.IDicHealthDao;
import com.inspur.cams.bpt.base.data.DicHealth;

/**
 * @title:DicHealthDao
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public class DicHealthDao extends EntityDao<DicHealth> implements IDicHealthDao{

 	
  	@Override
	public Class<DicHealth> getEntityClass() {
		return DicHealth.class;
	}
  	
    /**
     * 参战类别代码
     * 
     */
	public DataSet getAllWaraData() {
		return this.executeDataset("SELECT CODE,NAME FROM DIC_BPT_PUB A WHERE A.TYPE=12",  false);
	}
   
}
