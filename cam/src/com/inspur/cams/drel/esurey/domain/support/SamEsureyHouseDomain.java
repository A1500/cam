package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureyHouseDao;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;
import com.inspur.cams.drel.esurey.domain.ISamEsureyHouseDomain;
/**
 * @title:ISamEsureySocialDomain
 * @description:房管domain实现
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
public class SamEsureyHouseDomain implements ISamEsureyHouseDomain {
	@Reference(name = "samEsureyHouseDao")
	private ISamEsureyHouseDao samEsureyHouseDao ;
	
	public void batchDelete(String[] delIds) {
		// TODO Auto-generated method stub
		samEsureyHouseDao.batchDelete(delIds);
	}

	public void insert(SamEsureyHouse dataBean) {
		// TODO Auto-generated method stub
		samEsureyHouseDao.insert(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureyHouseDao.query(pset);
	}

	public void save(List<SamEsureyHouse> list) {
		// TODO Auto-generated method stub
		samEsureyHouseDao.save(list);
	}

	public void update(SamEsureyHouse dataBean) {
		// TODO Auto-generated method stub
		samEsureyHouseDao.update(dataBean);
	}
	public void delete(String peopleId){
		samEsureyHouseDao.delete(peopleId);
	}
	/**
	 * 保存房屋信息
	 */
	public void getSamEsureyHouse(SamEsureyHouse[] Beans,String peopleId){
		List<SamEsureyHouse> soList=new ArrayList<SamEsureyHouse>();
		for(int i=0;i<Beans.length;i++){
			SamEsureyHouse Bean=Beans[i];
			if(Beans[i].getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				Bean.setId(id);
				Bean.setFeedbackId(feedbackId);
				Bean.setPeopleId(peopleId);
				Bean.setType("1");	
			}else if(Beans[i].getState()==Record.STATE_MODIFIED){
				samEsureyHouseDao.update(Bean);
			}
			soList.add(Bean);
		}
		samEsureyHouseDao.save(soList);
	}

	public DataSet queryExtHouse(ParameterSet pset) {
		return samEsureyHouseDao.queryExtHouse(pset);
	}
	
	
}
