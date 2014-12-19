package com.inspur.cams.drel.esurey.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamEsureyRelation;

public interface ISamEsureyRelationDomain {

	public DataSet query(ParameterSet pset);
	@Trans
	public void insert(SamEsureyRelation bean);
	@Trans
	public void update(SamEsureyRelation bean);
	@Trans
	public void delete(String supportId);
	@Trans
	public void deleteByPeopleId(String peopleId);
	@Trans
	public void deleteSupFamily(String supFamId,String famId);
	 /**
	 * 根据家庭Id查找赡养家庭Id及人口数
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet queryRelFamiyIdNum(ParameterSet pset);
}
