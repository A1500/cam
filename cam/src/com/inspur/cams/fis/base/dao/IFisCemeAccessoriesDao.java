package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisCemeAccessories;

/**
 * 公墓审批附件表dao
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeAccessoriesDao extends BaseCURD<FisCemeAccessories> {
	
	/**
	 * 查询附件明细
	 * @param pset
	 * @return
	 */
	public DataSet queryAccessories(ParameterSet pset);
	
	/**
	 * 查询附件信息
	 * @param pset
	 * @return
	 */
	public DataSet queryAccessoriesItem(ParameterSet pset);
	
	public DataSet queryAccessoryType(ParameterSet pset);
	
	public void deleteAll(ParameterSet pset);
}