package com.inspur.cams.jcm.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.jcm.data.JcmOfficeEquipment;

/**
 * 办公设备信息dao
 * @author 
 * @date 2014-05-16
 */
public interface IJcmOfficeEquipmentDao extends BaseCURD<JcmOfficeEquipment> {
	
	/**
	 * 查询 办公设备信息
	 * @param pset
	 * @return
	 */
	public DataSet queryEquipmentInfo(ParameterSet pset);

}