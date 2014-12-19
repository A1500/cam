package com.inspur.cams.drel.special.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.special.dao.ISpecialpoorHelpVillageDao;
import com.inspur.cams.drel.special.data.SpecialpoorHelpVillage;
import com.inspur.cams.drel.special.domain.ISpecialpoorHelpVillageDomain;

/**
 * 帮包村信息表domain
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorHelpVillageDomain implements ISpecialpoorHelpVillageDomain {

	@Reference
	private ISpecialpoorHelpVillageDao specialpoorHelpVillageDao;

	/**
	 * 查询 帮包村信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return specialpoorHelpVillageDao.query(pset);
	}

	/**
	 * 获取 帮包村信息表
	 * @param pset
	 * @return
	 */
	public SpecialpoorHelpVillage get(String helpVillageCode) {
		return specialpoorHelpVillageDao.get(helpVillageCode);
	}

	/**
	 * 增加 帮包村信息表
	 * @param specialpoorHelpVillage
	 */
	public void insert(SpecialpoorHelpVillage specialpoorHelpVillage) {
		specialpoorHelpVillageDao.insert(specialpoorHelpVillage);
	}
	
	/**
	 * 修改 帮包村信息表
	 * @param specialpoorHelpVillage
	 */
	public void update(SpecialpoorHelpVillage specialpoorHelpVillage) {
		specialpoorHelpVillageDao.update(specialpoorHelpVillage);
	}
	
	/**
	 * 删除 帮包村信息表
	 * @param helpVillageCode
	 */
	public void delete(String helpVillageCode) {
		specialpoorHelpVillageDao.delete(helpVillageCode);
	}

}