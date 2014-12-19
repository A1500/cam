package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamFamilyAssistance;

/**
 * @title:家庭救助基本信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamFamilyAssistanceDomain {
	/**
	 * 查询救助基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加救助基本信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void insert(SamFamilyAssistance samFamilyAssistance);
	
	/**
	 * 更新救助基本信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void update(SamFamilyAssistance samFamilyAssistance);
	
	@Trans
	public void deleteByFamilyId(String familyId);
	@Trans
	public void deleteAssistance(String familyId,String assistanceType);
}
