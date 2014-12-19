package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamPeopleExtendDao;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
import com.inspur.cams.drel.sam.domain.ISamPeopleExtendDomain;
/**
 * @title:人员扩展信息Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamPeopleExtendDomain implements ISamPeopleExtendDomain {
	@Reference
	private ISamPeopleExtendDao samPeopleExtendDao;

	/**
	 * 增加人员扩展信息
	 * @param samPeopleExtend
	 */
	public void insert(SamPeopleExtend samPeopleExtend) {
		samPeopleExtendDao.insert(samPeopleExtend);
	}

	/**
	 * 查询人员扩展信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samPeopleExtendDao.query(pset);
	}

	/**
	 * 更新人员扩展信息
	 * @param samPeopleExtend
	 */
	public void update(SamPeopleExtend samPeopleExtend) {
		samPeopleExtendDao.update(samPeopleExtend);
	}

	/**
	 * 根据人员id删除人员扩展信息
	 * @param peopleId
	 */
	@Trans
	public void deleteByPeopleId(String peopleId) {
		samPeopleExtendDao.deleteByPeopleId(peopleId);
	}
}
