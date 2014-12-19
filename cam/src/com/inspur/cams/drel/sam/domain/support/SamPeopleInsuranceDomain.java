package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamPeopleInsuranceDao;
import com.inspur.cams.drel.sam.data.SamPeopleInsurance;
import com.inspur.cams.drel.sam.domain.ISamPeopleInsuranceDomain;
/**
 * @title:社会保险Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleInsuranceDomain implements ISamPeopleInsuranceDomain {
	@Reference
	private ISamPeopleInsuranceDao samPeopleInsuranceDao;
	/**
	 * 增加社会保险
	 * @param samPeopleInsurance
	 */
	public void insert(SamPeopleInsurance samPeopleInsurance) {
		samPeopleInsuranceDao.insert(samPeopleInsurance);
	}
	/**
	 * 查询社会保险
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleInsuranceDao.query(pset);
	}
	/**
	 * 更新社会保险
	 * @param samPeopleInsurance
	 */
	public void update(SamPeopleInsurance samPeopleInsurance) {
		samPeopleInsuranceDao.update(samPeopleInsurance);
	}
	
	/**
	 * 删除社会保险
	 * @param insuranceId
	 */
	@Trans
	public void delete(String insuranceId){
		samPeopleInsuranceDao.delete(insuranceId);
	}
	
	/**
	 * 根据人员id删除社会保险
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId){
		samPeopleInsuranceDao.deleteByPeopleId(peopleId);
	}
}
