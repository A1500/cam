package com.inspur.cams.jcm.dao;

import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.jcm.data.JcmAllUnitQuery;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * 所有单位信息表Dao
 * @author 陈寿业
 * @date 2014-12-15
 */
public interface IJcmAllUnitQueryDao extends BaseCURD<JcmAllUnitQuery> {
	
	
	/**
	 * 查询所有单位
	 */
	public DataSet queryAllUnit(ParameterSet pset);
}
