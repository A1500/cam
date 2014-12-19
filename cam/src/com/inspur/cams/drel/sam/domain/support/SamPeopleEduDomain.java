package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamPeopleEduDao;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;
import com.inspur.cams.drel.sam.domain.ISamPeopleEduDomain;
/**
 * @title:教育Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleEduDomain implements ISamPeopleEduDomain {
	@Reference
	private ISamPeopleEduDao samPeopleEduDao;

	/**
	 * 增加教育
	 * @param samPeopleEdu
	 */
	public void insert(SamPeopleEdu samPeopleEdu) {
		samPeopleEduDao.insert(samPeopleEdu);
	}
	/**
	 * 查询教育
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleEduDao.query(pset);
	}

	/**
	 * 更新教育
	 * @param samPeopleEdu
	 */
	public void update(SamPeopleEdu samPeopleEdu) {
		samPeopleEduDao.update(samPeopleEdu);
	}

	/**
	 * 删除教育
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId){
		samPeopleEduDao.delete(peopleId);
	}
}
