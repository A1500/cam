package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyInsuranceDao;
import com.inspur.cams.drel.esurey.data.SamEsureyInsurance;
import com.inspur.cams.drel.esurey.domain.ISamEsureyInsuranceDomain;
/**
 * @title:ISamEsureyInsuranceDomain
 * @description:证监domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyInsuranceDomain implements ISamEsureyInsuranceDomain {
	@Reference(name = "samEsureyInsuranceDao")
	private ISamEsureyInsuranceDao samEsureyInsuranceDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyInsuranceDao.batchDelete(delIds);
	}

	public void insert(SamEsureyInsurance dataBean) {
		// TODO Auto-generated method stub
		samEsureyInsuranceDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyInsuranceDao.query(pset);
	}

	public void save(List<SamEsureyInsurance> list) {
		// TODO Auto-generated method stub
		samEsureyInsuranceDao.save(list);
	}

	public void update(SamEsureyInsurance dataBean) {
		// TODO Auto-generated method stub
		samEsureyInsuranceDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureyInsuranceDao.delete(peopleId);
	}
	/*
	 * 保监信息
	 */
	public void getEsureyInsurance(SamEsureyInsurance[] Beans,String peopleId){
		List<SamEsureyInsurance> soList=new ArrayList<SamEsureyInsurance>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyInsurance Bean=Beans[i];
			if(Bean.getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");
			}else if(Bean.getState()==Record.STATE_MODIFIED){
				samEsureyInsuranceDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureyInsuranceDao.save(soList);
	}
	
	public DataSet queryExtInsurance(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyInsuranceDao.queryExtInsurance(pset);
	}
}
