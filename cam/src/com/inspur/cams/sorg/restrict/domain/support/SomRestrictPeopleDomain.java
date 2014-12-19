package com.inspur.cams.sorg.restrict.domain.support;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.restrict.dao.ISomRestrictPeopleDao;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeople;
import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDomain;

/**
 * 社会组织受限制人员表domain
 * 
 */
public class SomRestrictPeopleDomain implements ISomRestrictPeopleDomain {

	@Reference
	private ISomRestrictPeopleDao somRestrictPeopleDao;

	public DataSet query(ParameterSet pset) {
		return somRestrictPeopleDao.query(pset);
	}
	/**
	 * 保存受限人员：添加/更新受限人员表
	 * somRestrictPeople包含name、idCard、ifValid、ifLimit信息
	 */
	public String saveRestrictPeople(SomRestrictPeople somRestrictPeople){
		String idCard=somRestrictPeople.getIdCard();
		if(idCard==null||"".equals(idCard)){
			return null;
		}
		ParameterSet pset=new ParameterSet();
		pset.setParameter("ID_CARD", idCard);
		DataSet dset=somRestrictPeopleDao.query(pset);
		if(dset.getCount()>0){
			SomRestrictPeople bean=(SomRestrictPeople) dset.getRecord(0).toBean(SomRestrictPeople.class);
			bean.setName(somRestrictPeople.getName());
			bean.setIfValid(somRestrictPeople.getIfValid());
			somRestrictPeopleDao.update(bean);
			return bean.getPeopleId();
		}else{
			somRestrictPeople.setPeopleId(IdHelp.getUUID32());
			String ifLimit=somRestrictPeople.getIfLimit();
			if(ifLimit==null||"".equals(ifLimit)){				
				somRestrictPeople.setIfLimit("0");
			}
			somRestrictPeopleDao.insert(somRestrictPeople);
		}		
		return somRestrictPeople.getPeopleId();
	}
	public void update(SomRestrictPeople somRestrictPeople){
		somRestrictPeopleDao.update(somRestrictPeople);
	}
	public void delete(String peopleId){
		somRestrictPeopleDao.delete(peopleId);
	}
}
