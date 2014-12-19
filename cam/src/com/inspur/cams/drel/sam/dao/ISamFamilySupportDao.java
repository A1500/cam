package com.inspur.cams.drel.sam.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamFamilySupport;
/**
 * 赡扶抚养人Dao接口
 * @author yanliangliang
 *2012年5月2日9:45:43
 */
public interface ISamFamilySupportDao  extends BaseCURD<SamFamilySupport>{

	public void deleteByFamilyId(String familyId);

}
