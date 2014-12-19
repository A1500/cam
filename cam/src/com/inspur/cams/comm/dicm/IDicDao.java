package com.inspur.cams.comm.dicm;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.dicm.DicBean;

/**
 * 字典表dao接口
 * @author shgtch
 * @date 2011-5-14
 */
public interface IDicDao extends BaseCURD<DicBean> {
	
	public DataSet getDicMapList(ParameterSet pset);	
	/**
	 * 字典中根据key值获取对应的显示值
	 * @param tableName 表名
	 * @param key key转换为大写+"DM"为字典中的key
	 * @param keyV key值
	 * @return
	 */
	public String getValueByKey(String tableName, String key, String keyV);
	public DataSet queryType();
	
	public String getValueByValue(String tableName, String key, String keyV);
	
	//导出Excel解析字典
	public String getTextValueFromDic(String dic, String primaryKey, String primaryKeyValue, String queryField);
	
	
}
