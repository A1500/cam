package com.inspur.cams.bpt.base.domain.support;

import java.util.*;
import org.loushang.next.data.*;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.*;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoFamilyDao;
import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;


/**
 * @title:BptBaseinfoPeopleDomain
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public class BptBaseinfoPeopleDomain implements IBptBaseinfoPeopleDomain {

	private IBaseinfoPeopleDao baseinfoPeopleDao;
	private IBaseinfoFamilyDao  baseinfoFamilyDao;

	@Reference
	public void setBaseinfoPeopleDao(IBaseinfoPeopleDao baseinfopeopleDao) {
		this.baseinfoPeopleDao = baseinfopeopleDao;
	}

	public void saveBaseinfoPeople(List<BaseinfoPeople> list) {
		this.baseinfoPeopleDao.save(list);

	}

	@Reference
	public void setBaseinfoFamilyDao(IBaseinfoFamilyDao baseinfoFamilyDao) {
		this.baseinfoFamilyDao = baseinfoFamilyDao;
	}

	public void saveBaseinfoFamily(List<BaseinfoFamily> list) {
		this.baseinfoFamilyDao.save(list);

	}	
	
	
	/**
	 * 保存家庭和人员信息
	 */
	@Trans
	public void saveList(BaseinfoPeople baseinfoPeople,BaseinfoFamily baseinfoFamily) {
		insertFamily(baseinfoFamily);
		insertPeople(baseinfoPeople);
	}
	
	/**
	 * 保存家庭和人员信息
	 */
	@Trans
	public void updateList(BaseinfoPeople baseinfoPeople,BaseinfoFamily baseinfoFamily) {
		updateBaseinfoFamily(baseinfoFamily);
		updateBaseinfoPeople(baseinfoPeople);
	}
	
	/**
	 * 保存家庭信息
	 */
	public void insertFamily(BaseinfoFamily baseinfoFamily){
		baseinfoFamilyDao.insert(baseinfoFamily);
	}
	
	/**
	 * 保存人员信息
	 */
	public void insertPeople(BaseinfoPeople baseinfoPeople){
		baseinfoPeopleDao.insert(baseinfoPeople);
	}
	
	/**
	 * 查询人员信息
	 */
	public DataSet queryBaseinfoPeople(ParameterSet pset) {
		return baseinfoPeopleDao.query(pset);
	}
	
	/**
	 * 查询家庭人员信息
	 */
	public DataSet queryBaseinfoFamily(ParameterSet pset) {
		return baseinfoFamilyDao.query(pset);
	}
	
	/**
	 * 更新家庭信息
	 */
	public void updateBaseinfoFamily(BaseinfoFamily baseinfoFamily){
		baseinfoFamily.setModId(BspUtil.getEmpOrganId());
		baseinfoFamily.setModTime(DateUtil.getTime());
		baseinfoFamilyDao.update(baseinfoFamily);
	}

	/**
	 * 更新人员信息
	 */
	public void updateBaseinfoPeople(BaseinfoPeople baseinfoPeople){
		baseinfoPeople.setModId(BspUtil.getEmpOrganId());
		baseinfoPeople.setModTime(DateUtil.getTime());
		baseinfoPeopleDao.update(baseinfoPeople);
	}
	public DataSet queryDemobilizedFlowHeader(String peopleId) {
		// TODO Auto-generated method stub
		return baseinfoPeopleDao.queryDemobilizedFlowHeader(peopleId);
	}
}