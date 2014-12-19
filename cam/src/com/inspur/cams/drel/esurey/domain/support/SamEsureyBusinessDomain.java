package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyBusinessDao;
import com.inspur.cams.drel.esurey.data.SamEsureyBusiness;
import com.inspur.cams.drel.esurey.domain.ISamEsureyBusinessDomain;
/**
 * @title:ISamEsureyBusinessDomain
 * @description:工商domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyBusinessDomain implements ISamEsureyBusinessDomain {
	@Reference(name = "samEsureyBusinessDao")
	private ISamEsureyBusinessDao samEsureyBusinessDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyBusinessDao.batchDelete(delIds);
	}

	public void insert(SamEsureyBusiness dataBean) {
		// TODO Auto-generated method stub
		samEsureyBusinessDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyBusinessDao.query(pset);
	}

	public void save(List<SamEsureyBusiness> list) {
		// TODO Auto-generated method stub
		samEsureyBusinessDao.save(list);
	}

	public void update(SamEsureyBusiness dataBean) {
		// TODO Auto-generated method stub
		samEsureyBusinessDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureyBusinessDao.delete(peopleId);
	}
	/*
	 * 工商信息
	 */
	public void getSamEsureyBusiness(SamEsureyBusiness[] Beans,String peopleId){
		List<SamEsureyBusiness> soList=new ArrayList<SamEsureyBusiness>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyBusiness Bean=Beans[i];
			if(Beans[i].getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");
			}else if(Beans[i].getState()==Record.STATE_MODIFIED){
				samEsureyBusinessDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureyBusinessDao.save(soList);
	}	
	public DataSet queryExtBusiness(ParameterSet pset) {
		return samEsureyBusinessDao.queryExtBusiness(pset);
		
	}	
}
