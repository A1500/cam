package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamFamilySupport;

/**
 * @title:赡扶抚养人Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamFamilySupportDomain {
	/**
	 * 查询赡扶抚养人信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加赡扶抚养人信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void insert(SamFamilySupport samFamilySupport);
	
	/**
	 * 更新赡扶抚养人信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void update(SamFamilySupport samFamilySupport);
}
