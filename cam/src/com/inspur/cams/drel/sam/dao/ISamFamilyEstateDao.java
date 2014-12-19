package com.inspur.cams.drel.sam.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamFamilyEstate;
/**
 * 家庭财产信息Dao接口
 * @author yanliangliang
 *2012年5月2日9:45:43
 */
public interface ISamFamilyEstateDao extends BaseCURD<SamFamilyEstate>{

	public void deleteByFamilyId(String familyId);
	
}
