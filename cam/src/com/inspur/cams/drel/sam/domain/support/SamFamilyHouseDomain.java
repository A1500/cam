package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.sam.domain.ISamFamilyHouseDomain;
import com.inspur.cams.drel.sam.dao.ISamFamilyHouseDao;
import com.inspur.sdmz.jtxx.data.SamFamilyHouse;
/**
 * @title:房产Domain
 * @description:
 * @author: 张建
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamFamilyHouseDomain implements ISamFamilyHouseDomain {
	@Reference
	private ISamFamilyHouseDao samFamilyHouseDao;

	/**
	 * 增加房产
	 * @param samFamilyHouse
	 */
	public void insert(SamFamilyHouse samFamilyHouse) {
		samFamilyHouseDao.insert(samFamilyHouse);
	}
	/**
	 * 查询房产
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samFamilyHouseDao.query(pset);
	}

	/**
	 * 更新房产
	 * @param samFamilyHouse
	 */
	public void update(SamFamilyHouse samFamilyHouse) {
		samFamilyHouseDao.update(samFamilyHouse);
	}
	
	/**
	 * 删除房产
	 * @param houseId
	 */
	public void delete(String houseId){
		samFamilyHouseDao.delete(houseId);
	}
}
