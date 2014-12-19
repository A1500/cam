package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IDicOfficeEquipmentTypeDao;
import com.inspur.cams.jcm.data.DicOfficeEquipmentType;
import com.inspur.cams.jcm.domain.IDicOfficeEquipmentTypeDomain;

/**
 * 办公设备类别domain
 * @author 
 * @date 2014-05-21
 */
public class DicOfficeEquipmentTypeDomain implements IDicOfficeEquipmentTypeDomain {

	@Reference
	private IDicOfficeEquipmentTypeDao dicOfficeEquipmentTypeDao;

	/**
	 * 查询 办公设备类别
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicOfficeEquipmentTypeDao.query(pset);
	}

	/**
	 * 获取 办公设备类别
	 * @param pset
	 * @return
	 */
	public DicOfficeEquipmentType get(String code) {
		return dicOfficeEquipmentTypeDao.get(code);
	}

	/**
	 * 增加 办公设备类别
	 * @param dicOfficeEquipmentType
	 */
	public void insert(DicOfficeEquipmentType dicOfficeEquipmentType) {
		dicOfficeEquipmentTypeDao.insert(dicOfficeEquipmentType);
	}
	
	/**
	 * 修改 办公设备类别
	 * @param dicOfficeEquipmentType
	 */
	public void update(DicOfficeEquipmentType dicOfficeEquipmentType) {
		dicOfficeEquipmentTypeDao.update(dicOfficeEquipmentType);
	}
	
	/**
	 * 删除 办公设备类别
	 * @param code
	 */
	public void delete(String code) {
		dicOfficeEquipmentTypeDao.delete(code);
	}

}