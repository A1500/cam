package com.inspur.cams.drel.special.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.special.data.SpecialpoorHelpVillage;

/**
 * 帮包村信息表domain
 * @author 
 * @date 2013-08-12
 */
public interface ISpecialpoorHelpVillageDomain {

	/**
	 * 查询 帮包村信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 帮包村信息表
	 * @param pset
	 * @return
	 */
	public SpecialpoorHelpVillage get(String helpVillageCode);

	/**
	 * 增加 帮包村信息表
	 * @param specialpoorHelpVillage
	 */
	@Trans
	public void insert(SpecialpoorHelpVillage specialpoorHelpVillage);
	
	/**
	 * 修改 帮包村信息表
	 * @param specialpoorHelpVillage
	 */
	@Trans
	public void update(SpecialpoorHelpVillage specialpoorHelpVillage);
	
	/**
	 * 删除 帮包村信息表
	 * @param helpVillageCode
	 */
	@Trans
	public void delete(String helpVillageCode);

}