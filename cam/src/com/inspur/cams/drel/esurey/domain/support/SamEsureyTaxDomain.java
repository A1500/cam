package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyTaxDao;
import com.inspur.cams.drel.esurey.data.SamEsureyTax;
import com.inspur.cams.drel.esurey.domain.ISamEsureyTaxDomain;
/**
 * @title:ISamEsureyTaxDomain
 * @description:国税domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyTaxDomain implements ISamEsureyTaxDomain {
	@Reference(name = "samEsureyTaxDao")
	private ISamEsureyTaxDao samEsureyTaxDao;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyTaxDao.batchDelete(delIds);
	}

	public void insert(SamEsureyTax dataBean) {
		// TODO Auto-generated method stub
		samEsureyTaxDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyTaxDao.query(pset);
	}

	public void save(List<SamEsureyTax> list) {
		// TODO Auto-generated method stub
		samEsureyTaxDao.save(list);
	}

	public void update(SamEsureyTax dataBean) {
		// TODO Auto-generated method stub
		samEsureyTaxDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureyTaxDao.delete(peopleId);
	}
/*
 * 国税信息
 */
public void getEsureyTaxG(SamEsureyTax[] Beans,String peopleId){
	List<SamEsureyTax> soList=new ArrayList<SamEsureyTax>();
	for(int i=0;i<Beans.length;i++){
		SamEsureyTax Bean=Beans[i];
		if(Bean.getState()==Record.STATE_NEW){
			String id=IdHelp.getUUID30();
			String feedbackId=IdHelp.getUUID30();
			Bean.setId(id);
			Bean.setFeedbackId(feedbackId);
			Bean.setPeopleId(peopleId);
			Bean.setType("1");
			Bean.setTaxesType("0");
		}else if(Bean.getState()==Record.STATE_MODIFIED){
			samEsureyTaxDao.update(Bean);
		}	
		soList.add(Bean);
	}
	samEsureyTaxDao.save(soList);
}
/*
 * 地税信息
 */
public void getEsureyTaxD(SamEsureyTax[] Beans,String peopleId){
	List<SamEsureyTax> soList=new ArrayList<SamEsureyTax>();
	for(int i=0;i<Beans.length;i++){
		SamEsureyTax Bean=Beans[i];
		if(Bean.getState()==Record.STATE_NEW){
			String id=IdHelp.getUUID30();
			String feedbackId=IdHelp.getUUID30();
			Bean.setId(id);
			Bean.setFeedbackId(feedbackId);
			Bean.setPeopleId(peopleId);
			Bean.setType("1");
			Bean.setTaxesType("1");
		}else if(Bean.getState()==Record.STATE_MODIFIED){
			samEsureyTaxDao.update(Bean);
		}	
		soList.add(Bean);
	}
	samEsureyTaxDao.save(soList);
}
public DataSet queryGExtTax(ParameterSet pset) {
	
	return samEsureyTaxDao.queryGExtTax(pset);
}
public DataSet queryDExtTax(ParameterSet pset) {
	
	return samEsureyTaxDao.queryDExtTax(pset);
}
}
