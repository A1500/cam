package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamFamilyTreatment;

/**
 * @title:家庭待遇信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamFamilyTreatmentDomain {
	/**
	 * 查询家庭待遇信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	public DataSet queryAdjustList(ParameterSet pset);

	/**
	 * 增加家庭待遇信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void insert(SamFamilyTreatment samFamilyTreatment);
	
	/**
	 * 更新家庭待遇信息
	 * @param samFamilyTreatment
	 */
	@Trans
	public void update(SamFamilyTreatment samFamilyTreatment);
	/**
	 * 调整保障金
	 */
	@Trans
	public void updateAssistanceMoney(ParameterSet pset);	
	/**
	 * 调整所有保障金
	 * @param pset
	 */
	@Trans
	public void updateAllAssistanceMoney(ParameterSet pset);
	/**
	 * 身份证校验的时候查询待遇表，看是否正在进行救助
	 * @param pset
	 * @return
	 */
	public DataSet queryForCheckIDCard(ParameterSet pset);
	@Trans
	public void deleteTreatment(String familyId);
}
