package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureySecuritiesDao;
import com.inspur.cams.drel.esurey.data.SamEsureySecurities;
import com.inspur.cams.drel.esurey.domain.ISamEsureySecuritiesDomain;
/**
 * @title:ISamEsureySecuritiesDomain
 * @description:证监domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureySecuritiesDomain implements ISamEsureySecuritiesDomain {
	@Reference(name = "samEsureySecuritiesDao")
	private ISamEsureySecuritiesDao samEsureySecuritiesDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureySecuritiesDao.batchDelete(delIds);
	}

	public void insert(SamEsureySecurities dataBean) {
		// TODO Auto-generated method stub
		samEsureySecuritiesDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureySecuritiesDao.query(pset);
	}

	public void save(List<SamEsureySecurities> list) {
		// TODO Auto-generated method stub
		samEsureySecuritiesDao.save(list);
	}

	public void update(SamEsureySecurities dataBean) {
		// TODO Auto-generated method stub
		samEsureySecuritiesDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureySecuritiesDao.delete(peopleId);
	}
	/*
	 * 证监信息
	 */
	public void getEsureySecurities(SamEsureySecurities[] Beans,String peopleId){
		List<SamEsureySecurities> soList=new ArrayList<SamEsureySecurities>();
		for(int i=0;i<Beans.length;i++){
			SamEsureySecurities Bean=Beans[i];
			if(Bean.getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");
			}else if(Bean.getState()==Record.STATE_MODIFIED){
				samEsureySecuritiesDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureySecuritiesDao.save(soList);
	}
	public DataSet queryExtSecurities(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureySecuritiesDao.queryExtSecurities(pset);
	}
}
