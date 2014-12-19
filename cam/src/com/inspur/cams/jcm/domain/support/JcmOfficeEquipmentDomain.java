package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmOfficeEquipmentDao;
import com.inspur.cams.jcm.data.JcmOfficeEquipment;
import com.inspur.cams.jcm.domain.IJcmOfficeEquipmentDomain;

/**
 * 办公设备信息domain
 * @author 
 * @date 2014-05-16
 */
public class JcmOfficeEquipmentDomain implements IJcmOfficeEquipmentDomain {

	@Reference
	private IJcmOfficeEquipmentDao jcmOfficeEquipmentDao;

	/**
	 * 查询 办公设备信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmOfficeEquipmentDao.query(pset);
	}

	/**
	 * 获取 办公设备信息
	 * @param pset
	 * @return
	 */
	public JcmOfficeEquipment get(String officeId) {
		return jcmOfficeEquipmentDao.get(officeId);
	}

	/**
	 * 增加 办公设备信息
	 * @param jcmOfficeEquipment
	 */
	public void insert(JcmOfficeEquipment jcmOfficeEquipment) {
		jcmOfficeEquipmentDao.insert(jcmOfficeEquipment);
	}
	
	/**
	 * 修改 办公设备信息
	 * @param jcmOfficeEquipment
	 */
	public void update(JcmOfficeEquipment jcmOfficeEquipment) {
		jcmOfficeEquipmentDao.update(jcmOfficeEquipment);
	}
	
	/**
	 * 删除 办公设备信息
	 * @param officeId
	 */
	public void delete(String officeId) {
		jcmOfficeEquipmentDao.delete(officeId);
	}
	
	/**
	 * 查询 办公设备信息
	 * @param pset
	 * @return
	 */
	public DataSet queryEquipmentInfo(ParameterSet pset) {
		return jcmOfficeEquipmentDao.queryEquipmentInfo(pset);
	}

}