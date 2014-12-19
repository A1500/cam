package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.jtxx.data.SamFamilyHouse;
/**
 * @title:房产Domain接口
 * @description:
 * @author: 张建
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamFamilyHouseDomain {
	/**
	 * 查询房产
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加房产
	 * @param samFamilyHouse
	 */
	@Trans
	public void insert(SamFamilyHouse samFamilyHouse);
	
	/**
	 * 更新房产
	 * @param samFamilyHouse
	 */
	@Trans
	public void update(SamFamilyHouse samFamilyHouse);
	
	/**
	 * 删除房产
	 * @param houseId
	 */
	@Trans
	public void delete(String houseId);
}
