package com.inspur.cams.sorg.restrict.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.restrict.dao.ISomRestrictPeopleDetailDao;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeople;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;
import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDetailDomain;
import com.inspur.cams.sorg.restrict.domain.ISomRestrictPeopleDomain;
/**
 * 社会组织受限制人员明细表domain
 *
 */
public class SomRestrictPeopleDetailDomain implements ISomRestrictPeopleDetailDomain {

	@Reference
	private ISomRestrictPeopleDetailDao somRestrictPeopleDetailDao;
	@Reference
	private ISomRestrictPeopleDomain somRestrictPeopleDomain;

	public DataSet query(ParameterSet pset) {
		return somRestrictPeopleDetailDao.query(pset);
	}

	public DataSet queryPeople(ParameterSet pset) {
		return somRestrictPeopleDetailDao.queryPeople(pset);
	}
	/**
	 * 保存受限:添加/更新受限人员，添加受限人员明细
	 */
	public void saveRestrict(List<SomRestrictPeopleDetail> somRestrictPeopleDetailList){
		for (int i = 0; i < somRestrictPeopleDetailList.size(); i++) {
			SomRestrictPeopleDetail somRestrictPeopleDetail=somRestrictPeopleDetailList.get(i);
			if (somRestrictPeopleDetail.getState() == Record.STATE_NEW) {
				//添加/更新受限人员表
				String peopleId =saveRestrictPeople(somRestrictPeopleDetail.getSomRestrictPeople());
				if(peopleId==null){
					continue;
				}
				ParameterSet pset=new ParameterSet();
				pset.setParameter("ID_CARD", somRestrictPeopleDetail.getIdCard());
				pset.setParameter("TASK_CODE", somRestrictPeopleDetail.getTaskCode());
				DataSet dset=queryPeople(pset);
				if(dset.getCount()>0){
					continue;
				}
				somRestrictPeopleDetail.setId(IdHelp.getUUID30());
				somRestrictPeopleDetail.setPeopleId(peopleId);
				somRestrictPeopleDetail.setAddArea(BspUtil.getCorpOrgan().getOrganCode());
				somRestrictPeopleDetail.setAddPersonId(BspUtil.getEmpOrgan().getOrganId());
				somRestrictPeopleDetail.setAddPersonName(BspUtil.getEmpOrgan().getOrganName());
				somRestrictPeopleDetail.setAddTime(DateUtil.getTime());
				somRestrictPeopleDetail.setAddOrganId(BspUtil.getCorpOrgan().getOrganId());
				somRestrictPeopleDetail.setAddOrganName(BspUtil.getCorpOrgan().getOrganName());
				somRestrictPeopleDetail.setAddOperation("ADD");
				somRestrictPeopleDetailDao.insert(somRestrictPeopleDetail);
			} else if (somRestrictPeopleDetail.getState() == Record.STATE_MODIFIED) {
				somRestrictPeopleDomain.update(somRestrictPeopleDetail.getSomRestrictPeople());
			} else if (somRestrictPeopleDetail.getState() == Record.STATE_DELETED) {
				//受限记录
				ParameterSet pset=new ParameterSet();
				pset.setParameter("PEOPLE_ID", somRestrictPeopleDetail.getPeopleId());
				pset.setParameter("ID_CARD", somRestrictPeopleDetail.getIdCard());
				DataSet dset=queryPeople(pset);
				if(dset.getCount()>1){
					pset=new ParameterSet();
					pset.setParameter("TASK_CODE", somRestrictPeopleDetail.getTaskCode());
					pset.setParameter("PEOPLE_ID", somRestrictPeopleDetail.getPeopleId());
					deleteByTaskCode(pset);
				}else if(dset.getCount()==1){
					SomRestrictPeople somRestrictPeople=new SomRestrictPeople();
					somRestrictPeople.setIfValid("0");
					somRestrictPeopleDomain.update(somRestrictPeople);
				}
			}
		}
	}
	/**
	 * 添加受限:添加/更新受限人员，添加受限人员明细
	 */
	public void addRestrict(List<SomRestrictPeopleDetail> somRestrictPeopleDetailList){
		for (int i = 0; i < somRestrictPeopleDetailList.size(); i++) {
			SomRestrictPeopleDetail somRestrictPeopleDetail=somRestrictPeopleDetailList.get(i);
			//添加/更新受限人员表
			String peopleId =saveRestrictPeople(somRestrictPeopleDetail.getSomRestrictPeople());
			if(peopleId==null){
				continue;
			}
			ParameterSet pset=new ParameterSet();
			pset.setParameter("ID_CARD", somRestrictPeopleDetail.getIdCard());
			pset.setParameter("TASK_CODE", somRestrictPeopleDetail.getTaskCode());
			DataSet dset=queryPeople(pset);
			if(dset.getCount()>0){
				continue;
			}
			somRestrictPeopleDetail.setId(IdHelp.getUUID30());
			somRestrictPeopleDetail.setPeopleId(peopleId);
			somRestrictPeopleDetail.setAddArea(BspUtil.getCorpOrgan().getOrganCode());
			somRestrictPeopleDetail.setAddPersonId(BspUtil.getEmpOrgan().getOrganId());
			somRestrictPeopleDetail.setAddPersonName(BspUtil.getEmpOrgan().getOrganName());
			somRestrictPeopleDetail.setAddTime(DateUtil.getTime());
			somRestrictPeopleDetail.setAddOrganId(BspUtil.getCorpOrgan().getOrganId());
			somRestrictPeopleDetail.setAddOrganName(BspUtil.getCorpOrgan().getOrganName());
			somRestrictPeopleDetail.setAddOperation("ADD");
			somRestrictPeopleDetailDao.insert(somRestrictPeopleDetail);
		}
	}
	/**
	 * 保存受限人员：添加/更新受限人员表
	 */
	public String saveRestrictPeople(SomRestrictPeople somRestrictPeople) {
		return somRestrictPeopleDomain.saveRestrictPeople(somRestrictPeople);
	}
	/**
	 * 根据taskCode删除受限人员明细
	 */
	public void deleteByTaskCode(ParameterSet pset) {
		somRestrictPeopleDetailDao.deleteByTaskCode(pset);
	}
}
