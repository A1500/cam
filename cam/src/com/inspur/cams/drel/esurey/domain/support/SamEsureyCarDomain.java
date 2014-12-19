package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyCarDao;
import com.inspur.cams.drel.esurey.data.SamEsureyCar;
import com.inspur.cams.drel.esurey.domain.ISamEsureyCarDomain;
/**
 * @title:ISamEsureyCarDomain
 * @description:公安domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyCarDomain implements ISamEsureyCarDomain {
	@Reference(name = "samEsureyCarDao")
	private ISamEsureyCarDao samEsureyCarDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyCarDao.batchDelete(delIds);
	}

	public void insert(SamEsureyCar dataBean) {
		// TODO Auto-generated method stub
		samEsureyCarDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyCarDao.query(pset);
	}

	public void save(List<SamEsureyCar> list) {
		// TODO Auto-generated method stub
		samEsureyCarDao.save(list);
	}

	public void update(SamEsureyCar dataBean) {
		// TODO Auto-generated method stub
		samEsureyCarDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureyCarDao.delete(peopleId);
	}
	/*
	 * 车辆信息
	 */
	public void getSamEsureyCar(SamEsureyCar[] Beans,String peopleId){
		List<SamEsureyCar> soList=new ArrayList<SamEsureyCar>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyCar Bean=Beans[i];
			if(Bean.getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");
			}else if(Bean.getState()==Record.STATE_MODIFIED){
				samEsureyCarDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureyCarDao.save(soList);	
	}
	
	public DataSet queryExtCar(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyCarDao.queryExtCar(pset);
	}
}
