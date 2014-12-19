package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyBankDao;
import com.inspur.cams.drel.esurey.data.SamEsureyBank;
import com.inspur.cams.drel.esurey.domain.ISamEsureyBankDomain;
/**
 * @title:ISamEsureyBankDomain
 * @description:银行domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyBankDomain implements ISamEsureyBankDomain {
	@Reference(name = "samEsureyBankDao")
	private ISamEsureyBankDao samEsureyBankDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyBankDao.batchDelete(delIds);
	}

	public void insert(SamEsureyBank dataBean) {
		// TODO Auto-generated method stub
		samEsureyBankDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyBankDao.query(pset);
	}

	public void save(List<SamEsureyBank> list) {
		// TODO Auto-generated method stub
		samEsureyBankDao.save(list);
	}

	public void update(SamEsureyBank dataBean) {
		// TODO Auto-generated method stub
		samEsureyBankDao.update(dataBean);
	}
	
	public void delete(String peopleId){
		samEsureyBankDao.delete(peopleId);
	}
	/*
	 * 人行信息
	 */
	public void getEsureyBank(SamEsureyBank[] Beans,String peopleId){
		List<SamEsureyBank> soList=new ArrayList<SamEsureyBank>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyBank Bean=Beans[i];
			if(Bean.getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");
			}else if(Bean.getState()==Record.STATE_MODIFIED){
				samEsureyBankDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureyBankDao.save(soList);
	}
	public DataSet queryExtBank(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyBankDao.queryExtBank(pset);
	}
}
