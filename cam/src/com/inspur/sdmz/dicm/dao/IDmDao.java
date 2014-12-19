package com.inspur.sdmz.dicm.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.sdmz.dicm.data.DmBean;

/**
 * @title:IDmHzgxDao
 * @description:
 * @author:
 * @since:2011-04-30
 * @version:1.0
*/
 public interface IDmDao extends BaseCURD<DmBean>{
	public DataSet getDicMapList(ParameterSet pset);
	
	/**
	 * 字典中根据key值获取对应的显示值
	 * @param tableName 表名
	 * @param key key转换为大写+"DM"为字典中的key
	 * @param keyV key值
	 * @return
	 */
	public String getValueByKey(String tableName, String key, String keyV);
	
}

