package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamFamilyEstate;
/**
 * @title:家庭财产信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamFamilyEstateDomain {
	/**
	 * 查询家庭财产信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加家庭财产信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void insert(SamFamilyEstate samFamilyEstate);
	
	/**
	 * 更新家庭财产信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void update(SamFamilyEstate samFamilyEstate);
}
