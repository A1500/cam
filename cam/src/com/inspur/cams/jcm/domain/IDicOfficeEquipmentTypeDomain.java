package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.DicOfficeEquipmentType;

/**
 * 办公设备类别domain
 * @author 
 * @date 2014-05-21
 */
public interface IDicOfficeEquipmentTypeDomain {

	/**
	 * 查询 办公设备类别
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 办公设备类别
	 * @param pset
	 * @return
	 */
	public DicOfficeEquipmentType get(String code);

	/**
	 * 增加 办公设备类别
	 * @param dicOfficeEquipmentType
	 */
	@Trans
	public void insert(DicOfficeEquipmentType dicOfficeEquipmentType);
	
	/**
	 * 修改 办公设备类别
	 * @param dicOfficeEquipmentType
	 */
	@Trans
	public void update(DicOfficeEquipmentType dicOfficeEquipmentType);
	
	/**
	 * 删除 办公设备类别
	 * @param code
	 */
	@Trans
	public void delete(String code);
	
	

}