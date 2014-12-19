package com.inspur.cams.drel.esurey.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.esurey.dao.ISamEsureySocialDao;
import com.inspur.cams.drel.esurey.data.SamEsureySocial;
import com.inspur.cams.drel.esurey.domain.ISamEsureySocialDomain;
/**
 * @title:ISamEsureySocialDomain
 * @description:人力资源和社会保障domain实现
 * @author:luguosui
 * @since:2011-06-29
 * @version:1.0
*/
public class SamEsureySocialDomain implements ISamEsureySocialDomain{
	@Reference(name = "samEsureySocialDao")
	private ISamEsureySocialDao samEsureySocialDao ;
	
	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return samEsureySocialDao.query(pset);
	}

	public void batchDelete(String[] delIds) {
		samEsureySocialDao.batchDelete(delIds);
		
	}

	public void insert(SamEsureySocial dataBean) {
		samEsureySocialDao.insert(dataBean);
		
	}

	public void save(List<SamEsureySocial> list) {
		samEsureySocialDao.save(list);
		
	}

	public void update(SamEsureySocial dataBean) {
		samEsureySocialDao.update(dataBean);
		
	}
	public void delete(String peopleId){
		samEsureySocialDao.delete(peopleId);
	}
	/**
	 * 保存社保信息
	 * @param Beans
	 * @param peopleId
	 */
	public void getSamEsureySocial(SamEsureySocial[] Beans,String peopleId){
		List<SamEsureySocial> soList=new ArrayList<SamEsureySocial>();
		for(int i=0;i<Beans.length;i++){
			SamEsureySocial bean=Beans[i];
			if(Beans[i].getState()==Record.STATE_NEW){
				String id=IdHelp.getUUID30();
				String feedbackId=IdHelp.getUUID30();
				bean.setId(id);
				bean.setFeedbackId(feedbackId);
				bean.setPeopleId(peopleId);
				bean.setType("1");
			}else if(Beans[i].getState()==Record.STATE_MODIFIED){
				samEsureySocialDao.update(bean);
			}
			soList.add(bean);
		}
		samEsureySocialDao.save(soList);
	}
	public DataSet queryExtSocial(ParameterSet pset) {
		return samEsureySocialDao.queryExtSocial(pset);
	}
}
