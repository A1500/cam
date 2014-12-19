package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyHousingFundDao;
import com.inspur.cams.drel.esurey.data.SamEsureyHousingFund;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHousingFundDomain;
/**
 * @title:ISamEsureyHousingFundDomain
 * @description:公积金domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyHousingFundDomain implements ISamEsureyHousingFundDomain {
	@Reference(name = "samEsureyHousingFundDao")
	private ISamEsureyHousingFundDao samEsureyHousingFundDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyHousingFundDao.batchDelete(delIds);
	}

	public void insert(SamEsureyHousingFund dataBean) {
		// TODO Auto-generated method stub
		samEsureyHousingFundDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyHousingFundDao.query(pset);
	}

	public void save(List<SamEsureyHousingFund> list) {
		// TODO Auto-generated method stub
		samEsureyHousingFundDao.save(list);
	}

	public void update(SamEsureyHousingFund dataBean) {
		// TODO Auto-generated method stub
		samEsureyHousingFundDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureyHousingFundDao.delete(peopleId);
	}
	/*
	 * 公积金信息
	 */
	public void getEsureyFund(SamEsureyHousingFund[] Beans,String peopleId){
		List<SamEsureyHousingFund> soList=new ArrayList<SamEsureyHousingFund>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyHousingFund Bean=Beans[i];
			if(Bean.getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");
			}else if(Bean.getState()==Record.STATE_MODIFIED){
				samEsureyHousingFundDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureyHousingFundDao.save(soList);
	}
	public DataSet queryExtHousingFund(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyHousingFundDao.queryExtHousingFund(pset);
	}
}
