package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.JcmOfficeEquipment;

/**
 * 办公设备信息domain
 * @author 
 * @date 2014-05-16
 */
public interface IJcmOfficeEquipmentDomain {

	/**
	 * 查询 办公设备信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 办公设备信息
	 * @param pset
	 * @return
	 */
	public JcmOfficeEquipment get(String officeId);

	/**
	 * 增加 办公设备信息
	 * @param jcmOfficeEquipment
	 */
	@Trans
	public void insert(JcmOfficeEquipment jcmOfficeEquipment);
	
	/**
	 * 修改 办公设备信息
	 * @param jcmOfficeEquipment
	 */
	@Trans
	public void update(JcmOfficeEquipment jcmOfficeEquipment);
	
	/**
	 * 删除 办公设备信息
	 * @param officeId
	 */
	@Trans
	public void delete(String officeId);
	
	
	/**
	 * 查询 办公设备信息
	 * @param pset
	 * @return
	 */
	public DataSet queryEquipmentInfo(ParameterSet pset);

}