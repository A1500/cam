package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcBaseinfoPeopleDao;
import com.inspur.cams.cdc.base.data.CdcBaseinfoPeople;
import com.inspur.cams.cdc.base.domain.ICdcBaseinfoPeopleDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 人员基础信息domain
 * @author 
 * @date 2012-05-25
 */
public class CdcBaseinfoPeopleDomain implements ICdcBaseinfoPeopleDomain {

	@Reference
	private ICdcBaseinfoPeopleDao cdcBaseinfoPeopleDao;

	/**
	 * 查询 人员基础信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcBaseinfoPeopleDao.query(pset);
	}

	/**
	 * 获取 人员基础信息
	 * @param pset
	 * @return
	 */
	public CdcBaseinfoPeople get(String peopleId) {
		return cdcBaseinfoPeopleDao.get(peopleId);
	}

	/**
	 * 增加 人员基础信息
	 * @param cdcBaseinfoPeople
	 */
	public void insert(CdcBaseinfoPeople cdcBaseinfoPeople) {
		cdcBaseinfoPeople.setPeopleId(IdHelp.getUUID32());
		String familyId = cdcBaseinfoPeople.getFamilyId();
		if("".equals(familyId)||familyId==null){
			cdcBaseinfoPeople.setFamilyId(cdcBaseinfoPeople.getPeopleId());
		}
		cdcBaseinfoPeopleDao.insert(cdcBaseinfoPeople);
	}
	
	/**
	 * 修改 人员基础信息
	 * @param cdcBaseinfoPeople
	 */
	public void update(CdcBaseinfoPeople cdcBaseinfoPeople) {
		cdcBaseinfoPeopleDao.update(cdcBaseinfoPeople);
	}
	
	/**
	 * 删除 人员基础信息
	 * @param peopleId
	 */
	public void delete(String peopleId) {
		cdcBaseinfoPeopleDao.delete(peopleId);
	}

	public void deleteFamily(String peopleId) {
		cdcBaseinfoPeopleDao.deleteFamily(peopleId);
	}

}