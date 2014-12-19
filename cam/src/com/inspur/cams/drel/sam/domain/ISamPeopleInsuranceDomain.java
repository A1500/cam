package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;
/**
 * @title:社会保险Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleInsuranceDomain {
	/**
	 * 查询社会保险
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会保险
	 * @param samPeopleInsurance
	 */
	@Trans
	public void insert(SamPeopleInsurance samPeopleInsurance);
	
	/**
	 * 更新社会保险
	 * @param samPeopleInsurance
	 */
	@Trans
	public void update(SamPeopleInsurance samPeopleInsurance);
	
	/**
	 * 删除社会保险
	 * @param insuranceId
	 */
	@Trans
	public void delete(String insuranceId);
	
	/**
	 * 根据人员id删除社会保险
	 * @param peopleId
	 */
	@Trans
	public void deleteByPeopleId(String peopleId);
}
