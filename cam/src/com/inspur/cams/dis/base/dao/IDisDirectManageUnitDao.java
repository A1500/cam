package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.dis.base.data.DisDirectManageUnit;

/**
 * 直管单位配置表dao
 * @author 
 * @date 2012-11-19
 */
public interface IDisDirectManageUnitDao extends BaseCURD<DisDirectManageUnit> {

	/**
	 * @Description: 查询指定单位下的所有直属单位
	 * @author xuexzh
	 */
	DataSet queryAllUnit(ParameterSet pset);

}