package com.inspur.cams.drel.esurey.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.esurey.dao.ISamEsureyRelationDao;
import com.inspur.cams.drel.esurey.data.SamEsureyRelation;
import com.inspur.cams.drel.esurey.domain.ISamEsureyRelationDomain;

public class SamEsureyRelationDomain implements ISamEsureyRelationDomain{
	
	@Reference
	private ISamEsureyRelationDao samEsureyRelationDao;
	public void insert(SamEsureyRelation bean) {
		samEsureyRelationDao.insert(bean);
	}
	@Trans
	public DataSet query(ParameterSet pset) {
		return samEsureyRelationDao.query(pset);
	}
	@Trans
	public void update(SamEsureyRelation bean) {
		samEsureyRelationDao.update(bean);
	}
	@Trans
	public void delete(String supportId){
		samEsureyRelationDao.delete(supportId);
	}
	@Trans
	public void deleteByPeopleId(String peopleId){
		samEsureyRelationDao.deleteByPeopleId(peopleId);
	}
	public void deleteSupFamily(String supFamId, String famId) {
		samEsureyRelationDao.deleteSupFamily(supFamId, famId);
		
	}
	 /**
	 * 根据家庭Id查找赡养家庭Id及人口数
	 * @param pset
	 * @return
	 */
	public DataSet queryRelFamiyIdNum(ParameterSet pset){
		return samEsureyRelationDao.queryRelFamiyIdNum(pset);
	} 
}
